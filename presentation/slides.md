---
theme: ./theme
title: Extending your agent
subTitle: Configure → Extend → Compose → Ship
transition: fade
session-time: 90min
track: ai
type: Theoretical
first: 2026-07-01
---

# Extending your agent
## Configure → Extend → Compose → Ship

::image::

![](./images/cover-art.jpg)


---
layout: agenda
textSize: md
items:
  - The AI Track
  - Configure
  - Marketplaces
  - Plugin Primitives
  - Skills & Monitors
  - Agents & Settings
  - Hooks
  - MCP & LSP
---

---
layout: full
---

<TheAlignmentProblem />

---
layout: full
---

<MoreSessions />

---
layout: full
---

<HackatonConcept2 img="playbook-manual.png" />

---
layout: full
---

<HackatonEvent />


---
layout: default-aside
---

# This is just for developers, right?

- Create Excel functions and graphs
- Create PowerBI report or SQL queries
- Crunch the numbers for a +1 report
- Prioritization and backlog trimming
- Brainstorm UX / wireframes <small>(Claude Design?)</small>
- Drop in all analysis documents and ask questions
  - Adversarial Review of the analysis or acceptance criteria
  - Run ad-hoc tests to find missing functionality/bugs
    - While you're getting coffee
- Find a good restaurant for the next team lunch

::image::

![](./images/not-just-developers.jpg)

---
layout: statement
---


On Terminal Bench 2.0, one team moved a coding agent from outside
the top 30 into the top 5 by changing only the harness, with the
same model underneath.

::image::

![](/team-climbing.webp)


<!--
https://addyosmani.com/blog/new-sdlc-vibe-coding/
-->

---
layout: section
background: knobs2.jpg
---

# Configure

::subtitle::

Turn knobs · Make it your own



---
layout: quote
---

# Claude Configuration


`~/.claude/settings.json`

`/update-config` and `/config`

`/doctor` if it messed up

::image::

![](./images/knobs1.jpg)

<!--
Don't configure yourself, let Claude do it for you!  
For many of the configs, you'll have to restart the harness
-->


---
layout: default-aside
textSize: sm
---

# Context Engineering

<v-clicks depth="2">

- `/statusline`: crucial!
  - Must see: `context_window.used_percentage`
  - There is also `subagentStatusLine`
- `autoCompactEnabled` & `autoCompactWindow`
  - Do not lean on compaction: land the plane and `/clear`!
- `/memory`: Injected close to the action
  - `autoMemoryEnabled`
  - `autoMemoryDirectory` -> `~/.claude/projects/<dir>/memory`
    - **Progressive Context Disclosure** with `MEMORY.md` index
  - `autoDreamEnabled`: auto clean & dedupe
- `/rewind`: if the model went off-track
  - `fileCheckpointingEnabled` also restore all changed files

</v-clicks>


<div v-click class="full-width text-2xl italic text-orange-400 mt-6">

The middle is the dumb zone,
<br>start thinking about a new session around <b>40%</b> usage
</div>

::image::

![](./images/context-engineering.jpg)

<!--
`/branch`: split the current session to try alternative approaches, then `/resume` to go back to original session  
`/fork`: put current work in background agent which returns to current session when done  
`/btw`: ask a quick question in current context without polluting the main thread  
-->


---
layout: default-aside
---

# Look & Feel

<v-clicks depth="2">

- The most important one: `spinnerVerbs`
- `footerLinksRegexes` <small>(requires `FORCE_HYPERLINK` on WSL)</small>
- `/color` & `/rename`: manage multiple sessions
  - Combine it with `git worktree`
- `/tui fullscreen` & `/focus`: zen mode
- `/keybindings` -> `~/.claude/keybindings.json`
- `attribution` & `includeGitInstructions`
- `preferredNotifChannel` --> Use a hook instead!
- env: `CLAUDE_CODE_DISABLE_FEEDBACK_SURVEY=1`

</v-clicks>

::image::

![](./images/look-and-feel.jpg)


<!--
`/theme`: light/dark theme  
worktrees:  
- [obra/superpowers using-git-worktrees](https://github.com/obra/superpowers/blob/main/skills/using-git-worktrees/SKILL.md)
- symlinkDirectories: for node_modules, ... sharing (speedup)
- sparsePaths: in monorepos, only checkout certain directories (speedup)
- baseRef: start from HEAD or origin/main

keybindings with `"EDITOR": "vim"` on WSL or you'll need to do some path translation magic

preferredNotifChannel: Poor support on Windows, use a custom hook
-->


---
layout: default-aside
h1:
  type: hash
  color: muted
  position: start
---

# Behavior

<v-clicks depth="2">

- `/model`: 1 Opus == +/-5 Sonnet tokens
- `advisorModel` and `/advisor`: adversarial review by a stronger model
- `/effort`: low (faster) -> xhigh (smarter)
  - `ultra` burn all the tokens (fan out, pipelines, verify, judge, ...) - Trigger with "ultracode"
- `alwaysThinkingEnabled`: false == answer straight away.
  - `Ctrl + O` to see "internal thinking" or `showThinkingSummaries`
- `/fast` & `fastMode`: pay more for faster replies
- `outputStyle`: Default / Proactive / Explanatory / Learning
  - ... Or drop in Caveman ;)
  - `/powerup` for interactive learning; or just `/help`

</v-clicks>

::image::

![](./images/behavior.jpg)


<!--
Ultra: no constraint, multi agent, dynamic workflow. (understand → design → implement → (adversarial) review)  
Caveman: why use many token when few token do trick  
ex: I have a "Bash-explained" custom output style
-->

---
layout: default-aside
textSize: sm
---

# Security

<v-clicks depth="2">

- `Shift + Tab` to cycle between permission modes
  - `skipDangerousModePermissionPrompt`: YOLO🎉
  - `auto` (configurable) middle ground between ask-all & yolo
- `/permissions`: Allow / Deny / Ask
- `additionalDirectories` & `/add-dir`
- `sandbox`: on the OS level <small>(macOS, Linux, WSL2)</small>
  - egress and (credential, ...) file blocks
- `claude --cloud`: run it on Anthropic's servers

</v-clicks>

<div v-click class="full-width text-2xl italic text-orange-400 mt-20">

`deny: [Read(**/secrets)]` only stops the Read tool,
<br>it does not stop a Python script from reading that file.
<br>That is where the sandbox comes in.

</div>

::image::

![](./images/security.jpg)

<!--
sandbox:
- bubblewrap (bwrap) — the walls (Linux namespaces container-like command wrapper that hides files, processes, network)
- seccomp — the rules of conduct (shrinks the attack surface by blocking syscalls: ptrace, raw sockets, mount)
- socat — the monitored mail slot (the allowedDomains pinhole through bwrap)

On Windows: there is an npm package.
-->


---
layout: default-aside
textSize: sm
---

# On the go
## Take it with you

<v-clicks depth="2">

- Connect Github & Slack (`@claude`) for "coding" on the go
- `/teleport` picks up a mobile session
- `/remote-control` continue a session on mobile
- `inputNeededNotifEnabled`: mobile push when your input is needed
- `agentPushNotifEnabled`: mobile push to inform you of something noteworthy

</v-clicks>

<div v-click class="full-width text-2xl italic text-orange-400 mt-6">

Set a `/goal`, enable `/rc`, go to the sauna
<br>and get a `inputNeededNotifEnabled` ping when done.

</div>

<div v-click class="full-width text-2xl italic text-orange-400 mt-6">

Continuing on the homelab open-space session: combine this with something
like Coolify for deploying changes and testing them on the go 🏕️

</div>

::image::

![](./images/on-the-go.jpg)


<!--
claude --cloud: Claude Code on the web (Anthropic's infra, no bash)  
  Set up a fitting environment for the project `/remote-env`
claude --bg: run headless in the background  
claude ssh: drive a session on a remote box  
-->


---
layout: section
background: marketplaces.jpg
---

# Marketplaces


---
layout: code
---

# Marketplace
## A catalog of Plugins

A git repository with `.claude-plugin/marketplace.json`

<v-click>

```json
{
  "name": "superpowers-marketplace",
  "owner": { "name": "Jesse Vincent", "email": "jesse@fsck.com" },
  "metadata": {
    "description": "Skills, workflows, and productivity tools",
    "version": "1.0.13"
  },
  "plugins": [{
    "name": "superpowers",
    "source": { "source": "url", "url": "https://github.com/obra/superpowers" },
    "description": "Core skills library: TDD, debugging, collaboration patterns, and proven techniques",
    "version": "6.0.3"
  }]
}
```

</v-click>

<!--
- `source.source`: can also be "github", "npm", "git-subdir" (sparse for monorepos), or source can be a relative path
  - ref: which branch, sha: the git sha
- plugins can also contain: author, category, keywords, homepage, ...
- strict: who is the authority for the metadata (false: marketplace vs true (default):plugin itself)
- dependencies: depend on a plugin from another marketplace
-->


---
layout: default-aside
---

# Marketplaces

<v-clicks depth="2">

- `/plugin marketplace add affaan-m/ECC`
  - In `settings.json` as `extraKnownMarketplaces`
- `add` vs `remove`, `update`, `list`
- Some marketplaces
  - `claude-plugins-official`: 150+ vetted plugins
    - superpowers ships with the official marketplace!
  - `claude-plugins-community`: huge list, lots of noise
  - `wshobson/agents`: multi-harness agent collection
  - `VoltAgent/awesome-claude-code-subagents`: 100+ specialized
  - `davepoon/buildwithclaude`: ~70 plugins, curated

</v-clicks>

<div v-click class="full-width text-2xl italic text-orange-400 mt-6">

See the `README.md` for sites where you can explore/discover more.<br>
And `research/Analysts` specifically for FA/BA/PO roles.

</div>

::image::

![](./images/market-setup.jpg)


<!--
Also in settings.json: blockedMarketplaces  
strictKnownMarketplaces: only allow these
-->


---
layout: section
background: plugins.jpg
---

# Plugins

::subtitle::

What the marketplaces offer...


---
layout: default-aside
h2:
  type: brackets
  color: primary
  position: all
---

# Plugins
## The harness, packaged and shippable

<v-clicks depth="2">

- A **plugin** is a directory which bundles:
  - **Skills** — model-invoked capabilities
    - **Slash Commands** — user-invoked workflows (folded into skills)
  - **Agents** — specialized subagents, isolated context
  - **Hooks** — deterministic events
  - **MCP servers** — stateful connections
  - **LSP servers** — AI intellisense
  - **Monitors** — background jobs

</v-clicks>

<div v-click class="full-width text-2xl italic text-orange-400 mt-8">

A plugin is installed with your permissions.<br>
ToxicSkills: ~36% of skills in the wild include malware, prompt injection, exposed secrets.

</div>

::image::

![](./images/plugin-bundle.jpg)

<!--
Hooks can run any code (ex: on SessionStart)  
Before installing one, have a quick glance at the hooks (and maybe the skills).

Snyk findings: https://snyk.io/blog/toxicskills-malicious-ai-agent-skills-clawhub/
-->

---
layout: code
---

# Plugin
## The Plugin Manifest

`.claude-plugin/plugin.json`

```json
{
  "name": "superpowers",
  "description": "Core skills library for Claude Code: TDD, debugging, collaboration patterns, and proven techniques",
  "version": "6.0.3",
  "author": { "name": "Jesse Vincent", "email": "jesse@fsck.com" },
  "homepage": "https://github.com/obra/superpowers",
  "repository": "https://github.com/obra/superpowers",
  "license": "MIT",
  "keywords": [
    "skills", "tdd", "debugging",
    "collaboration", "best-practices", "workflows"
  ]
}
```

<!--
"skills": "./custom/skills/",
"commands": ["./custom/commands/special.md"],
"agents": ["./custom/agents/reviewer.md"],
"hooks": "./config/hooks.json",
"mcpServers": "./mcp-config.json",
"outputStyles": "./styles/",
"lspServers": "./.lsp.json",
"experimental": {
  "themes": "./themes/",
  "monitors": "./monitors.json"
},
"dependencies": [
  "helper-lib",
  { "name": "secrets-vault", "version": "~2.1.0" }
]
-->



---
layout: code
---

# Plugin Install
## The Extending-Your-Agent-Tutorial

```bash
/plugin marketplace add https://github.com/itenium-be/Extending-Your-Agent
/plugin install extending-your-agent-tutorial@extending-your-agent
/reload-plugins
```

<div v-click class="mt-12">

<PluginPayload />

</div>


<!--
# The ASCII dependency
claude plugin marketplace add rawveg/skillsforge-marketplace
claude plugin install figlet-text-converter@skillsforge-marketplace
-->


---
layout: section
background: skills.jpg
---

# Skills

::subtitle::

Anything that can be a Skill should be one.


---
layout: statement
---

# I expect we’ll see a Cambrian explosion in Skills which will make this year’s MCP rush look pedestrian by comparison.
## Simon Willison

<!-- https://simonwillison.net/2025/Oct/16/claude-skills/ -->

---
layout: default-aside
---

# Skills
## Our first, amazing, skill, the Greeter!

```bash
# /extending-your-agent-tutorial:hello
/greeter what we've been postponing
```

<div v-click class="mt-20">

<GreeterDemo />

</div>

::image::

![](./images/greeter.jpg)

<!--
monitors.json: optional field: "when": "on-skill-invoke:greeter"
-->



---
layout: default-aside
textSize: sm
---

# Skills
## Want to create a skill?

<v-clicks depth="2">

- Do it manually, then have Claude write it up
  - Refine it after each use <small>(till perfection)</small>
  - Use `skill-creator@claude-plugins-official`
  - Or `/superpowers:writing-skills`
- Keep it under 500 lines
  - Conciseness check & Progressive Disclosure
- Workflows with clear steps `- [ ] Step 1 (run init.py)`

</v-clicks>


<EvalsVsGitRecipes />

::image::

![](./images/skill-creating.jpg)

<!--
disableBundledSkills, skillListingMaxDescChars, skillOverrides
-->


---
layout: code-comparison
before-label: Won't route
after-label: Routes
code-size: 0.92em
---

# A description is a trigger, not a label
## The description IS the interface

::before::

```yaml
---
name: db-helper
description: Database utilities
---
```

::after::

```yaml
---
name: db-helper
description: >
  Use when the user asks to inspect, query, or
  migrate the Postgres schema — runs read-only
  SQL and returns the result set. Not for writes.
---
```

<!--
Left: the model has no "when". Right: explicit trigger + scope + boundary.
"Use when..." is the single highest-leverage phrasing.
-->


---
layout: section
---

# Agents



---
layout: default
---

# Subagents — author for isolation

<v-clicks depth="2">

- A separate session, its own context — returns a **summary**, not raw output
- Author it like a skill: name + **description = the dispatch decision**
- Two payoffs: **context isolation** and **parallel fan-out**
- Reach for it when: noisy reads, multi-perspective review, independent work
- Skill vs subagent: same instruction, but need a *clean* window? → subagent

</v-clicks>

<div v-click class="full-width text-xl italic text-orange-400 mt-6">
⚠️ Footgun — a subagent <b>inherits tools & permissions</b>.
An auto-dispatched agent's blast radius is whatever you granted the parent.
</div>

<!--
Callback: AI-Driven-Development "Sub-agents" + "Multi-Agent Review". There: what they are.
Here: how to author one well, and the permission-inheritance trap.
-->


---
layout: default
---

# Hooks — author for determinism

<v-clicks depth="2">

- Shell commands fired on lifecycle events — the model **can't talk its way out**
- Event model: `PreToolUse` (the only one that can **block**), `PostToolUse`, `Stop`, `SessionStart`, …
- Exit code is the contract: non-zero on `PreToolUse` = denied
- Use for guardrails: format-on-write, block writes to `main`, run the linter

</v-clicks>

<div v-click class="full-width text-xl italic text-orange-400 mt-6">
⚠️ Footgun — hook config <b>executes on load</b> (CVE-2025-59536).
A repo's <code>.claude/settings.json</code> is code, not config.
</div>

<!--
Callback: AI-Driven-Development "Hooks > Instructions". There: why hooks beat prompting.
Here: the event model + the load-time execution risk.
-->


---
layout: default
textSize: sm
h2:
  type: brackets
  color: muted
  position: all
---

# MCP — the map

## we build one for real on Oct 1

<v-clicks depth="2">

- **6 primitives**: tools, resources, prompts (server) · **sampling, elicitation, roots** (client)
- Two transports: **stdio** (local) · **HTTP** (remote)
- The client-side three are what every "hello tool" tutorial skips
  - Live contradiction: *elicitation* shipped June-2025 spec — Claude Code still doesn't support it (VS Code does)
- When **MCP** vs **CLI** vs **Skill**? Stateful connection → MCP. "Run this, read output" → CLI/Skill

</v-clicks>

<div v-click class="full-width text-xl italic text-orange-400 mt-5">
⚠️ Footgun — mcp-remote RCE (CVE-2025-6514); a 2026 scan found ~200k exposed instances.
</div>

<!--
FLEX BUFFER — if running long, compress to this one slide. Depth is reserved for Oct 1.
Verify: elicitation support status (today is post-research), the ~200k figure.
-->


---
layout: code
code-textSize: 1.1em
---

# This is the whole server

## (and that's October's talk)

```python
from fastmcp import FastMCP

mcp = FastMCP("itenium-tool")

@mcp.tool()
def lookup(ticket_id: str) -> dict:
    """Fetch an itenium ticket by id."""
    return client.get(ticket_id)

mcp.run()  # stdio by default
```

<!--
The ~10-line teaser. Do NOT walk through scaffolding/auth/inspector here — that's Oct 1.
Just: "a tool is a typed function with a docstring-as-description". Then move on.
-->


---
layout: section
---

# Compose & package

::subtitle::

From a folder of skills to your team's playbook


---
layout: default
---

# Plugins — one installable unit

<v-clicks depth="2">

- `mkdir → plugin.json → SKILL.md → /plugin` — ship in one breath
- Bundles skills + subagents + hooks + pre-configured MCP servers together
- **Skills-in-git → plugin**: your team's runbook becomes installable
- Marketplaces: official + community — `/plugin marketplace add`, then `/plugin install`

</v-clicks>

<div v-click class="full-width text-2xl italic text-orange-400 mt-6">
The unit of distribution is the unit of trust.
</div>

<!--
The part the prior talk never touched. Packaging is what makes authoring pay off across a team.
-->


---
layout: default
textSize: sm
h1:
  type: hash
  color: muted
  position: start
---

# Footgun · the marketplace is the supply chain

<v-clicks>

- **ToxicSkills** audit: 36.8% of skills had ≥1 flaw, 13.4% critical
- Dependency-hijack PoCs against marketplace installs
- **Rug-pull**: a trusted tool updated *after* you approved it — manifests aren't version-locked
- Defences: allowlists + **version locks**, manifest **pinning/signing**, read before you install

</v-clicks>

<div v-click class="full-width text-xl italic text-orange-400 mt-6">
You'd never <code>npm install</code> blind. Don't <code>/plugin install</code> blind.
</div>

<!-- Verify the ToxicSkills percentages (Snyk). -->


---
layout: section
---

# Ship with confidence

::subtitle::

How do you know the thing you authored works?


---
layout: default
---

# Test your extensions

<v-clicks depth="2">

- The gap nobody fills: you'd never ship a function with no test — why ship a skill with none?
- **Extension-specific** checks:
  - Does the **description trigger** when it should — and *not* when it shouldn't?
  - Does a **subagent** get dispatched on the right prompts?
  - Did a bundled dependency **rug-pull** since last run? (diff the manifest)
- Lightweight first: a per-PR smoke check beats a perfect eval platform you never build

</v-clicks>

<div v-click class="full-width text-2xl italic text-orange-400 mt-6">
Rubrics, judges, golden datasets, CI gates — that's a whole session of its own.
</div>

<!--
⚠️ DRAFT — backing research in flight (extension-specific testing). General eval methodology
is deliberately OUT (its own session). Keep this narrow: testing what YOU authored.
Refine once the research lands.
-->


---
layout: section
---

# Operate at scale

::subtitle::

Beyond the CLI, and what it costs


---
layout: default
---

# Agent SDK & headless

<v-clicks depth="2">

- Same agent, **no interactive shell** — embed it in apps, scripts, CI
- `claude -p --bare` = reproducible runs: skips local config discovery, identical across machines
- The Agent SDK `query()` API: programmatic agents, your own harness
- Heads-up: SDK billing **separated** from interactive limits (15 June 2026)

</v-clicks>

<div v-click class="full-width text-2xl italic text-orange-400 mt-6">
The harness boundary isn't the CLI — it's the SDK.
</div>

<!--
Verify the June-15 billing split + that --bare behaves as described before presenting.
-->


---
layout: default
textSize: sm
---

# The economics force discipline

<v-clicks depth="2">

- Enterprise average: **~$13 / dev / active day** (~$150–250 / dev / month)
- **Agent teams** (parallel instances) burn **~7×** the tokens of a standard session
  - Each runs in its own git **worktree** — `worktree.symlinkDirectories` (share `node_modules`) + `sparsePaths` (skip the monorepo) keep that affordable on disk & setup
- This is exactly why progressive disclosure + tight descriptions matter
- A bloated `CLAUDE.md` and 20 always-on MCP tools is a recurring tax on every session

</v-clicks>

<div v-click class="full-width text-2xl italic text-orange-400 mt-6">
Authoring discipline is what makes the tooling sustainable at team scale.
</div>

<!-- Verify the $13/day and 7× figures (Claude Code costs docs). -->


---
layout: section
---

# Wrapping up


---
layout: default
---

# Every footgun is the same shape

<v-clicks>

- **Lethal trifecta** = private data + untrusted instructions + an exfiltration vector
- Plugin trust · skill `!cmd` · subagent permissions · hook execution · marketplace rug-pull
- Each extension layer makes assembling the trifecta *accidentally* easier
- The registry-as-trust-root is the only real answer — and it isn't solved yet

</v-clicks>

<div v-click class="full-width text-2xl italic text-orange-400 mt-6">
You're not just extending the agent — you're extending its attack surface.
</div>

<!-- Simon Willison's lethal trifecta. This is the security through-line, woven, now tied off. -->


---
layout: default
---

# What's actionable

<v-clicks>

- Write the **description first** — it's the interface, for every primitive
- Make it a **Skill** unless you need state (→ MCP) or determinism (→ Hook)
- **Package** your team's playbook as a plugin; read before you install
- **Test** what you authored; never `/plugin install` blind
- Keep `CLAUDE.md` lean — progressive disclosure is a budget decision

</v-clicks>


---
layout: statement
textSize: lg
---

# July: theory → **12 Aug: you build** → Oct: an MCP server

::author::

See you at the hackathon

<!-- Pay off the ramp from the teaser. Drive signups. -->



---
layout: default
---

# Call to action

<v-clicks>

- `#boekenclub`: join us for "The Alignment Problem"
- Join Claude hack-a-tons during office days, first one on **12 august**!
- Turn your `~/.claude` into a git repository
- Turn knobs and see what happens in `settings.json`
  - `/statusline`, `/update-config`
- Install `obra/superpowers` or `affaan-m/ECC`
- Learn with `/powerup`, `/help` or `outputStyle: Learning`


</v-clicks>


---
layout: socials
---


---
layout: source
source: itenium-be/Extending-Your-Agent
---


---
layout: end
---
