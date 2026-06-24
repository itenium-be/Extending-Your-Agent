# MCP, Skills, Extending your agent — talk design

**Format:** virtual, theoretical, no audience interaction. 90 min, full depth.
**Series:** 4th in a recurring deep-dive series for the same expert-dev audience.
**Repo:** this one (`Extending-Your-Agent`), itenium Slidev theme.

## Audience & the gap this talk fills

Same audience as *AI Driven Development* (`2026-05-11-AI-Driven-Development`, 120 min).
They already have the **concepts** of skills, MCP, CLIs, sub-agents, hooks,
progressive disclosure, the CLAUDE.md hierarchy, and the
`chat → CLAUDE.md → skill → harness` decision ladder. They've heard
"Hooks > Instructions" and "Docs ❌ · Skills ✅".

So this talk does **not** re-define the primitives. Its job is the next layer:
**how to author good extensions and compose/ship them** — with security woven in
and scale economics as the closer.

| Already delivered (prior talk)        | This talk's material                              |
|---------------------------------------|---------------------------------------------------|
| What skills/MCP/subagents/hooks are   | How to **author** good ones (description-as-interface) |
| Progressive disclosure (context idea) | Progressive disclosure as **authoring architecture** |
| Subagents as context-isolation        | **Authoring** subagents + orchestration patterns  |
| Hooks > instructions (concept)        | Hooks as the **determinism layer** you author     |
| MCP exists, schema cost vs CLI        | MCP at decision/composition level (build is Oct)  |
| —                                     | **Plugins & the Marketplace** (untouched before)  |
| —                                     | **Evals / testing** your extensions before shipping |
| —                                     | **Agent SDK / headless** + operating at scale     |
| Hooks as guardrails                   | Trust boundary **woven** per layer; lethal trifecta as closer |

## Scope boundary vs other sessions

Upcoming series sessions:

- **2026-09-01 — RAG & Embeddings** (no overlap)
- **2026-10-01 — MCP Servers: Is This How Skynet Started?** — hands-on *build a
  real MCP server against an internal itenium tool*. **Overlap risk.**
- **Evals session (planned, undated)** — two full blueprints exist
  (`2026-06-04-evals-...` + `2026-06-09-evals-vibes-don-t-scale-...`): golden
  datasets, LLM-as-judge, CI gates, metrics. **Overlap risk with §5.**
- Undated — *Agent Cage Match & Model Bake-Off*, *Text-to-SQL & Semantic Search*.

**The line with October:** July treats MCP as a **design / decision / composition**
topic; October is the **build**. July keeps conceptual depth (primitive map,
transports at a glance, when MCP-vs-CLI-vs-skill, client-side primitives, security)
plus **one ~10-line "what a server looks like" teaser snippet, explicitly flagged
"we go deep next time."** No server scaffolding walkthrough in July. The built-live
arc is **skill → plugin** only; the "+ MCP tool" leg is October's material.

## Decisions

- **Spine:** "You know they exist — author your own, compose, test, and ship them."
  Arc: **author every primitive → compose → test → operate.** The layer cake is the
  organizing metaphor.
- **Primitives get peer treatment:** Skills, Subagents, Hooks, MCP are authored
  side-by-side, each applying the description-as-interface principle. MCP is no
  longer a tentpole — it's one of four.
- **MCP is the flex buffer:** if running short on time, **compress the MCP
  sub-section first** (its depth is reserved for Oct 1 anyway).
- **Security:** woven into each layer (one footgun per primitive), tied together as
  the lethal trifecta in the wrap. No standalone security section.
- **Length:** design for full 90 min; MCP absorbs overruns.
- **Code depth:** decided per-section while building (diagram vs snippet vs
  annotated artifact vs recorded built-live arc). Not locked here.

## Outline

**Teaser — AI hackatons + 12 Aug (1–2 slides).** Promote the AI Center of
Excellence hands-on hackatons. First one: **12 Aug 2026**, office day, 90 min,
mob-style, open to anyone (non-devs welcome, subs on itenium) — mob-migrate a real
Angular app's Reactive Forms → **Signal Forms** (Angular 22) with Claude Code +
**MCP servers**, against a green Playwright net. Ties the series together:
**July (theory) → 12 Aug (hands-on with MCP) → Oct 1 (build an MCP server)**.
Source: `bliki/AI-tenium/ai-hackaton`.

**Cold open — bridge.** "Last time, the pieces and why context discipline matters.
Today, author your own and ship them to your team." One-slide layer-cake recap.

**1. Composition, not selection — the layer cake.** *(~8 min)*
Plugin bundles skills / subagents / hooks / MCP servers. The decision question:
*context problem, determinism problem, or defaults problem?* Subagents = isolation,
hooks = determinism, the rest = substrate. Sets the map for the whole talk.
↳ footgun: installing a plugin = trusting everything it bundles; hook config can
run *before* the trust dialog (CVE-2025-59536).

**2. The description is the interface — the cross-cutting principle.** *(~7 min)*
The universal contract: the same `description` field is the activation signal for
skills, the tool-selection signal for MCP, the dispatch signal for subagents. Wrong
description = routing failure that compounds. Progressive disclosure as
*architecture*, not an optimization (skills ~100 tokens at startup; body loads on
demand). **This principle is applied by every primitive in §3.**

**3. Authoring the primitives.** *(~36 min — the meat)*
Each primitive is authored through the §2 lens, with its own trust footgun.

- **Skills** *(~10 min).* Anatomy, scoped triggers, layered detail, when a skill
  beats CLAUDE.md / a slash command. ↳ footgun: prompt injection in skill content;
  the dynamic `` !`cmd` `` runs *before* the model sees the skill, so model-level
  defences never fire (ToxicSkills: 91% of malicious skills use this).
- **Subagents** *(~10 min).* Authoring a good one, context isolation, orchestration
  / fan-out patterns, subagent-vs-skill. ↳ footgun: a subagent inherits tools &
  permissions — blast radius of an auto-dispatched agent.
- **Hooks** *(~8 min).* The determinism layer: event model (only `PreToolUse`
  blocks), authoring deterministic policy/guardrails, exit codes. ↳ footgun: hook
  config executes on load (CVE-2025-59536); the "TrustFall" clone-and-run pattern.
- **MCP** *(~8 min — FLEX BUFFER, conceptual; build is Oct 1).* The 6 primitives as
  a *map*; stdio vs HTTP at a glance; client-side primitives nobody teaches
  (sampling / elicitation / roots) + the live spec contradiction; when MCP vs CLI
  vs skill. **One ~10-line "what a server looks like" teaser, flagged "we build one
  for real Oct 1."** No scaffolding walkthrough. ↳ footgun: mcp-remote RCE
  (CVE-2025-6514), ~200k exposed instances. **Compress this first if short on time.**

**4. Compose & package — Plugins & the Marketplace.** *(~8 min)*
Wrap skill + subagent + hook + MCP into one installable plugin. Official +
community marketplaces. Shipping your team's playbook (skills-in-git → plugin).
*The part the prior talk never touched.*
↳ footgun: ToxicSkills (36.8% of skills flawed, 13.4% critical), dependency-hijack
PoCs — the marketplace is the supply chain.

**5. Ship with confidence — testing your extensions.** *(~8 min)*
*Narrow, extension-specific — general eval methodology is its own session.*
How do you *know* a skill / subagent / plugin works before shipping it to the team?
The extension-specific angle only: a regression check for the skill you authored,
catching the rug-pull when a bundled dependency updates, smoke-testing a subagent's
routing. **Defer rubrics / LLM-as-judge / golden datasets / CI delta gates to the
evals session** — point at it, don't teach it. Closes with "there's a whole session
on doing this properly."

**6. Operate at scale — Agent SDK / headless & cost.** *(~8 min)*
Build-your-own-harness with the Agent SDK (query() API); `claude -p --bare` for
reproducible CI; the June-15-2026 SDK billing split; ~$13/dev/active day; agent
teams burn ~7× tokens. Why authoring discipline is what makes this sustainable.

**Wrap.** *(~5 min)*
Decision-framework recap. The **lethal trifecta** (private data + untrusted
instructions + exfiltration vector) as the through-line tying every per-primitive
footgun together — each layer makes assembling it accidentally easier. The ramp
(July theory → 12 Aug hands-on → Oct 1 MCP build) as the "what's next" hook.

## Source material

Two existing research bundles (in the Atlas repo) back this:

- `research/2026-05-23-extending-claude-code-mcp-skills-plugins-a-session-3-blueprint`
  — survey: layer cake, comparison, security trifecta, delivery plan (85 citations).
- `research/2026-06-03-extending-claude-code-session-4-authoring-craft-operating-at-scale`
  — craft: description-as-interface, progressive disclosure, client-side MCP
  primitives, tool-poisoning, scale/cost, Agent SDK (73 citations).

Each section's child docs carry the citations to pull stats/quotes from while
building slides. Backing per section: Skills/MCP/Plugins/scale → both bundles;
Subagents/Hooks → session-3 `subagents-hooks-and-the-rest-of-the-harness` +
session-4 `claude-agent-sdk-headless-agents`; Agent SDK → session-4 SDK child.

Evals bundles (general methodology, for the evals session — §5 only points at these):
`research/2026-06-04-evals-how-do-you-know-your-ai-works-session-blueprint` and
`research/2026-06-09-evals-vibes-don-t-scale-a-complete-technical-session-blueprint`.

**Gap — needs fresh research:** the narrow §5 angle — *testing agent extensions
specifically* (regression-checking an authored skill/subagent/plugin, rug-pull
detection on a bundled dependency). The existing evals bundles are general/RAG and
don't cover applying evals to extensions. Keep the scope tight so it doesn't eat
the evals session.

## Open / decide-while-building

- Per-section presentation format (diagram vs code vs recorded arc).
- Whether the built-live arc (**skill → plugin**, MCP deferred to Oct) spans
  sections 2 and 4 or is a single recorded segment.
- Cover art (`presentation/images/cover-art.jpg`) and `ElevatorPitch.md`.
- `subTitle` for the deck.
