# Testing & regression-checking Claude Code extensions before shipping to a team

*Scoped to extension/agent-config testing (Skills, subagents, hooks, plugins, MCP) — NOT general LLM/model-output eval. Compiled 2026-06-24. Primary sources preferred; 2026-current facts flagged.*

> **Headline finding:** the field is **lopsided**. MCP/plugin supply-chain testing is mature and CI-ready (multiple real tools, a named CVE, vendor backing). Skill-body testing has essentially **one** documented harness (MLflow). Subagent routing tests are **inherently probabilistic** and nobody has a clean deterministic answer. "Nobody has it fully solved yet" is the honest state for tracks (1) and (2).

---

## 1. Testing an authored Skill (trigger + body)

**Trigger = the `description` field.** A Skill loads when Claude judges the prompt matches the YAML `description`, so "does it trigger / does it misfire" reduces to testing that one string's discriminating power. You test it by running the *same skill* under multiple prompts and asserting load vs. no-load.

**The reference harness is MLflow's [`github.com/mlflow/skills`](https://github.com/mlflow/skills)** ([mlflow.org blog, "Testing and Refining Claude Code Skills with MLflow"](https://mlflow.org/blog/evaluating-skills-mlflow/)). Shape:

| Piece                     | What it does                                                                                                                                  |
| ------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------- |
| `tests/test_skill.py`     | Custom orchestrator — runs each config as an isolated Claude Code session [[1]][m1]                                                            |
| `tests/configs/*.yaml`    | Per-test config: `name`, `project_dir`, `setup_script`, `prompt`, `timeout_seconds`, `allowed_tools`, `judges`, `skills` [[1]][m1]             |
| Multiple configs / skill  | Different `prompt` values assert the skill **triggers OR stays dormant** under varied conditions [[1]][m1]                                     |
| `tests/judges/` (7 files) | Score the resulting session trace                                                                                                             |

[m1]: https://mlflow.org/blog/evaluating-skills-mlflow/

> Verbatim: *"a single skill can be covered by multiple configs with different prompts, letting you verify that the skill triggers (or doesn't trigger) correctly under a range of conditions."* [[1]][m1]

**Body verification** = instrument the session, then assert on what it *did*: `mlflow autolog claude /path` turns every tool call into a trace span, then two judge types score the trace — LLM judges via `make_judge()` for procedural correctness, and **rule-based `@scorer` judges that check real side effects** in the modified test environment (e.g. `@scorer(name="dataset-created")` queries the env to confirm the artifact was actually created) [[1]][m1]. The rule-based side-effect assertion is the part that's *not* LLM-eval and is the most directly transferable pattern for a deterministic CI gate.

**Lighter-weight skill linting** also exists: `pulser` (`pulserin/pulser@v1`), a zero-dependency CLI surfaced for skill-file CI validation (YAML frontmatter checks, structural validation) per [dev.to: "Testing Claude Code Skills in CI"](https://dev.to/thestack_ai/testing-claude-code-skills-in-ci-pulser-eval-github-action-3na9). Treat as static/structural validation, not behavioral.

> ⚠️ **Thin-field flag:** Anthropic's own [`github.com/anthropics/skills`](https://github.com/anthropics/skills) ships **no testing harness, CI, or regression patterns** — verified by adversarial check (claim refuted 0-3 *because* the repo has none). Practitioners roll their own; MLflow is effectively the only structured published harness.

---

## 2. Smoke-testing a subagent's routing

**Routing is governed entirely by the subagent's `description` frontmatter** — Claude reads each subagent's description and auto-delegates on match ([Claude Code sub-agents docs](https://code.claude.com/docs/en/sub-agents)): *"Claude uses each subagent's description to decide when to delegate tasks… When Claude encounters a task that matches a subagent's description, it delegates."* [[2]][sa] So routing tests = description discriminating-power tests, and they are **probabilistic** (a model judgment, not a deterministic match).

[sa]: https://code.claude.com/docs/en/sub-agents

**Three test levers (all from primary docs [[2]][sa]):**

| Lever                          | Use in testing                                                                                                                              |
| ------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------ |
| `--agents` JSON CLI flag       | Define **ephemeral** subagents at launch; session-only, **not written to disk** — docs position this for *"quick testing or automation scripts"* [[2]][sa] |
| `@agent-<name>` mention        | **Deterministic positive control** — guarantees that subagent runs, bypassing the routing decision (tests the body, not the router) [[2]][sa] |
| Natural-language prompt        | Exercises the **real routing-decision path** — Claude still decides whether to delegate [[2]][sa]                                            |

Practical pattern: use `@agent-<name>` to prove the isolated context behaves correctly (deterministic), and a battery of natural-language should-route / should-NOT-route prompts to probe the description boundary (probabilistic — expect flake, run N times, gate on a rate not a single pass).

> ⚠️ **Unsettled flag:** there is **no published CI convention** for gating PRs on probabilistic routing. Open question whether teams gate on natural-language routing assertions at all, or only on `@agent-mention` positive controls. Third-party framing exists (e.g. [futureagi "the dispatch is the unit", 2026](https://futureagi.com/blog/evaluating-claude-sub-agents-2026/)) but it's blog-level, not tooling.

---

## 3. Regression-testing a plugin/MCP server & catching a "rug-pull"

**This is the mature, security-driven track — and the most clearly 2026-current.**

**The threat — "rug-pull":** a server silently changes a tool's description/behavior *after* the client already approved it, with **no re-approval**, because the MCP spec doesn't require re-approval on a description change ([Invariant Labs, "Tool Poisoning Attacks"](https://invariantlabs.ai/blog/mcp-security-notification-tool-poisoning-attacks); [practical-devsecops rug-pull glossary](https://www.practical-devsecops.com/glossary/rug-pull-attack-in-mcp/)). Related Tool Poisoning embeds hidden instructions in descriptions the **model reads in full while the user sees a simplified version** — a visibility gap [[3]][inv].

[inv]: https://invariantlabs.ai/blog/mcp-security-notification-tool-poisoning-attacks

**The canonical real-world case: CVE-2025-54136 ("MCPoison")**, disclosed by [Check Point](https://research.checkpoint.com/2025/cursor-vulnerability-mcpoison/). Cursor bound trust to the approved config *key name* rather than the underlying command, so a once-approved benign config could later have its command swapped to run arbitrary code with no re-prompt. CVSS 7.2, affected Cursor ≤1.2.4; **fixed in Cursor v1.3 (2025-07-29)**, which now requires re-approval on any MCP config change [[4]][rp]. *2025-dated but it's the defining precedent for 2026 MCP-regression practice.*

[rp]: https://www.practical-devsecops.com/glossary/rug-pull-attack-in-mcp/

**Consensus defense** (pin + diff + audit) — [Invariant][inv], [practical-devsecops][rp], [OWASP MCP Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/MCP_Security_Cheat_Sheet.html):
- **Pin every server/tool by exact version AND content hash/checksum** — not just name — and verify integrity before execution [[3]][inv][[5]][rp]
- **Diff every server update before it loads** [[5]][rp]
- **Audit `mcp.json` in git** so unexpected manifest changes surface in code review [[5]][rp]
- ⚠️ Caveat: hash-pinning is **necessary but not sufficient** — hash trust depends on the delivery channel and on actually scanning the description text.

**CI-ready tooling (all primary repos):**

| Tool                                   | What it does for regression / rug-pull                                                                                                                          | CI hook                                                  |
| -------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------- |
| **MCPhound** [[6]][mh]                  | **Content-hashes each server's tool definitions; Critical warning if a package's tools change** (not version-based) — direct rug-pull detection                  | `--ci` (exit 1), `tayler-id/mcphound-action@v0`, SARIF→Code Scanning, PR comment [[6]][mh] |
| **Snyk Agent Scan** [[7]][ms]           | The **2026 rebrand of `invariantlabs-ai/mcp-scan`** (Snyk acquired Invariant Labs, announced **2025-06-24**). Scans MCP servers, agent skills & tools for 15+ risks; **Tool Pinning** hashes tools & tracks changes to detect rug-pulls | `uvx snyk-agent-scan@latest`; `inspect` (print, no verify) vs `scan` (verify) [[7]][ms] |
| **MCP Inspector** [[8]][insp]           | Official; **CLI mode** lists+executes tools, lists+retrieves resources, lists+samples prompts — i.e. verify the full tool/resource/prompt manifest               | Docs explicitly position CLI for *"scripting, automation, and CI/CD"* [[8]][insp] |
| **YawLabs/mcp-compliance** [[9]][cmp]   | **88 spec tests / 8 categories** (Transport, Lifecycle, Tools, Resources, Prompts, Error Handling, Schema Validation, Security); A–F grading                     | `YawLabs/mcp-compliance@v0`, `strict: true min-grade: A`, SARIF/JSON/markdown [[9]][cmp] |

[mh]: https://github.com/tayler-id/mcphound
[ms]: https://github.com/invariantlabs-ai/mcp-scan
[insp]: https://github.com/modelcontextprotocol/inspector
[cmp]: https://github.com/YawLabs/mcp-compliance

> ⚠️ **Maturity flag:** MCPhound and mcp-compliance are both **@v0** (early/unstable) and **single-maintainer** projects — vet before depending on them in *blocking* CI. Snyk Agent Scan is the vendor-backed option. **Open question:** whether Claude Code / the plugin marketplace offers *native* manifest pinning/signing — as of research, rug-pull defense appears to be **entirely third-party + git-auditing `mcp.json`**.

---

## 4. The realistic lightweight per-PR end (no eval platform)

**[`anthropics/claude-code-action@v1`](https://code.claude.com/docs/en/github-actions)** runs an authored skill/plugin in per-PR CI with zero eval infrastructure [[10]][gha]:

- **Repo-local skill:** `actions/checkout` → pass `/skill-name` as the prompt, on `pull_request: [opened, synchronize]` [[10]][gha]
- **Plugin-packaged skill:** install via `plugin_marketplaces` (marketplace Git URL) + `plugins` inputs → pass namespaced `/plugin-name:skill-name` [[10]][gha]

[gha]: https://code.claude.com/docs/en/github-actions

> Verbatim: *"For a skill in your repository's `.claude/skills/` directory, run `actions/checkout` before the action step and pass `/skill-name`. For a skill packaged in a plugin, install the plugin with the `plugin_marketplaces` and `plugins` inputs and pass the namespaced `/plugin-name:skill-name`."* [[10]][gha]

**A small team's realistic per-PR stack:**
1. Structural lint of skill/subagent frontmatter (`pulser` or a homegrown YAML check) — cheap, deterministic.
2. `claude-code-action@v1` invoking the skill on a couple of representative prompts + a `@agent-<name>` positive-control dispatch [[10]][gha][[2]][sa].
3. One MCP rug-pull gate in CI: `mcphound --ci` **or** `snyk-agent-scan` over `mcp.json`, plus `mcp.json` reviewed in the PR diff [[6]][mh][[7]][ms][[5]][rp].
4. Rule-based side-effect assertions (MLflow `@scorer` pattern) for any skill with a checkable artifact — avoids standing up an LLM-judge pipeline [[1]][m1].

---

## 5. Tool / repo index (extension-config testing, not model evals)

| Tool / repo                                | Track            | Status / 2026 note                                          |
| ------------------------------------------ | ---------------- | ---------------------------------------------------------- |
| [mlflow/skills][m1r]                        | Skill harness    | De-facto reference; LLM + rule-based judges                |
| `pulserin/pulser@v1`                        | Skill lint/CI    | Structural validation in CI                                |
| [claude-code-action@v1][gha]                | Per-PR CI        | Runs skills/plugins on PR events                           |
| [code.claude.com/docs sub-agents][sa]       | Subagent routing | `--agents`, `@agent-`, NL routing                          |
| [tayler-id/mcphound][mh]                    | MCP rug-pull     | Hash-diff, `@v0`, GH Action + SARIF                        |
| [Snyk Agent Scan (ex mcp-scan)][ms]         | MCP scan/pin     | **2026 rebrand** of mcp-scan; Tool Pinning                 |
| [modelcontextprotocol/inspector][insp]      | MCP manifest     | Official; CLI mode for CI                                  |
| [YawLabs/mcp-compliance][cmp]               | MCP spec tests   | 88 tests, A–F, `@v0`, GH Action                            |
| [OWASP MCP Security Cheat Sheet][owasp]      | Defense ref      | Pinning w/ cryptographic hashes                            |

[m1r]: https://github.com/mlflow/skills
[owasp]: https://cheatsheetseries.owasp.org/cheatsheets/MCP_Security_Cheat_Sheet.html

*One-line pointer (out-of-scope overlap):* MLflow's skill harness also does LLM-as-judge scoring of traces [[1]][m1] — that half is general-eval territory, covered by the separate talk; only its rule-based side-effect `@scorer` belongs here.

---

## Slide-ready takeaways

1. **The field is lopsided.** MCP/plugin supply-chain testing is *solved enough to gate CI today* (MCPhound, Snyk Agent Scan, MCP Inspector, mcp-compliance — content-hash pinning + manifest diffing). Skill-body testing has **one** real harness (MLflow); subagent-routing testing is **inherently probabilistic** with no CI convention. If your talk needs an honest line: *"plugins you can regression-test; skills and routing you mostly smoke-test and pray."*

2. **"Rug-pull" is the concrete, nameable threat — lead with the CVE.** CVE-2025-54136 / **MCPoison** (Cursor, fixed v1.3, 2025-07-29): trust was bound to the config *name*, not the *command*, so an approved tool was swapped silently. Defense is mechanical and demoable: **pin by content hash, diff on update, audit `mcp.json` in git** — and `mcphound --ci` literally fails the build when a tool definition's hash changes.

3. **You can ship a per-PR safety net with two GitHub Actions and no eval platform.** `claude-code-action@v1` runs your skill on representative prompts (+ a `@agent-` positive control for routing); `mcphound`/`snyk-agent-scan` guards the manifest. The deterministic-assertion trick worth stealing: MLflow's **rule-based `@scorer` checks real side effects** (did the artifact get created?) instead of judging prose — cheap, flake-free, and outside model-eval scope.

---

*Adversarial verification: 25 claims triple-checked, 23 confirmed (3-0), 2 refuted (the "anthropics/skills has a harness" claims — it doesn't). Sources skew primary (Anthropic docs, MLflow, GitHub repos, Check Point, OWASP, Invariant Labs); rug-pull defense recs lean partly on a secondary glossary but are corroborated by OWASP + Check Point primary research.*
