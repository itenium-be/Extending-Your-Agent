---
theme: ./theme
title: MCP, Skills, Extending your agent
subTitle: Author your own, compose them, ship them to your team
transition: fade
session-time: 90min
track: ai
type: Theoretical
first: 2026-07-01
---

# MCP, Skills, Extending your agent
## Author your own · compose · ship to your team

::image::

![](./images/cover-art.jpg)

<!--
Session 4 in the series. Prior: AI & security · context/compounding/harness · AI-Driven-Development.
They know the pieces exist. Today: how to author good ones and ship them.
-->


---
layout: agenda
textSize: md
items:
  - The AI Track
  - Composition, not selection
  - The description is the interface
  - Authoring the primitives
  - Compose & package
  - Ship with confidence
  - Operate at scale
---

---
layout: full
---

<TheAlignmentProblem />

---
layout: default
textSize: lg
---

- 1 September 2026 - RAG & Embeddings
- 1 October 2026 — MCP Servers: Is This How Skynet Started?
- 25 November 2026 — Predicting Mental Fatigue Using AI
- December 2026 — The Math Behind the AI Curtain
- Date? Agent Cage Match & Model Bake-Off
- Date? Text-to-SQL & Semantic Search



---
layout: statement
textSize: lg
---

# 🚀 First AI Hackathon — **12 August**


::author::

itenium AI Center of Excellence

<!--
Teaser slide 1. Sell the room on the hands-on track before going theoretical.
-->


---
layout: default
h1:
  type: hash
  color: primary
  position: start
---

# AI Hackathons

<v-clicks>

- **#1 — 12 Aug**, office day, 90 min, mob-style — **anyone welcome** (non-devs too, subs on itenium)
- Mob-migrate a real Angular app: **Reactive Forms → Signal Forms** (Angular 22)
- Driven by **Claude Code + MCP servers**, against a green **Playwright** safety net
- Scoreboard: tokens burned + tests passing. Topic board: what we mob next

</v-clicks>

<div v-click class="full-width text-2xl italic text-orange-400 mt-6">
Today is theory. 12 Aug you build. Oct 1 you build an MCP server for real.
</div>

<!--
The ramp: July theory → Aug hands-on → Oct MCP build. Plant it now, pay it off in the wrap.
Source: bliki/AI-tenium/ai-hackaton
-->


---
layout: statement
---

# Last time: the pieces exist.
# Today: **author your own** and ship them.

<!--
Cold open / bridge. AI-Driven-Development already taught what skills/MCP/subagents/hooks ARE,
progressive disclosure, the chat→CLAUDE.md→skill→harness ladder, "Hooks > Instructions".
This talk is the next layer: the craft of authoring + composing + shipping.
-->


---
layout: section
---

# Composition, not selection

::subtitle::

The four primitives don't compete — they nest


---
layout: default
---

# The layer cake

<v-clicks depth="2">

- A **plugin** is the packaging unit — it bundles:
  - **Skills** — on-demand instructions
  - **Subagents** — isolated context
  - **Hooks** — deterministic events
  - **MCP servers** — stateful connections
- A skill with `context: fork` *runs inside* a subagent
- A hook can fire *on a subagent's* tool call

</v-clicks>

<div v-click class="full-width text-2xl italic text-orange-400 mt-6">
Teach the nesting first — or the audience hears four overlapping pitches.
</div>

<!--
Last session ended on "harness engineering". This is the harness, packaged and shippable.
-->


---
layout: default
h2:
  type: brackets
  color: primary
  position: all
---

# One question routes everything

## context · determinism · defaults

<v-clicks>

- **Context problem?** → Skill or subagent (isolation, on-demand loading)
- **Determinism problem?** → Hook (only `PreToolUse` can *block*)
- **Defaults problem?** → settings, permissions, CLAUDE.md
- **Reaching outside the box?** (DB, OAuth, live UI) → MCP

</v-clicks>

<div v-click class="full-width text-2xl italic text-orange-400 mt-6">
Subagents give isolation. Hooks give determinism. The rest is substrate.
</div>

<!--
This is the decision spine for the whole talk. Each primitive section answers one of these.
-->


---
layout: default
textSize: sm
h1:
  type: hash
  color: muted
  position: start
---

# Footgun · composition

<v-clicks>

- Installing a plugin = **trusting everything it bundles** — at once
- `CVE-2025-59536`: hook config executes **before** the trust dialog
- "TrustFall": cloning a hostile repo runs code on open
- One `/plugin install` pulls skills + hooks + MCP + subagents you never read

</v-clicks>

<div v-click class="full-width text-xl italic text-orange-400 mt-6">
Convenience and blast radius are the same mechanism.
</div>

<!-- Footgun #1. We tie all footguns together as the lethal trifecta in the wrap. -->


---
layout: section
---

# The description is the interface

::subtitle::

The one field that routes every primitive


---
layout: default
---

# `description` is the universal contract

<v-clicks depth="2">

- The **same field** drives routing in three places:
  - **Skill** — the activation signal (does it load?)
  - **MCP tool** — the selection signal (does the model pick it?)
  - **Subagent** — the dispatch signal (does the parent spawn it?)
- Get it wrong and it's not a docs bug — it's a **routing failure**
- And the failure is silent: the primitive just never fires

</v-clicks>

<div v-click class="full-width text-2xl italic text-orange-400 mt-6">
Write the description before you write the body.
</div>


---
layout: code-comparison
before-label: Won't route
after-label: Routes
code-size: 0.72em
---

# A description is a trigger, not a label

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
layout: default
---

# Progressive disclosure is the architecture

<v-clicks depth="2">

- Not an optimization — it's *how the primitive is shaped*
- **Skill**: ~100 tokens at startup (name + description). Body loads only when relevant
- **MCP Tool Search**: tool names upfront, full schemas deferred — up to **95%** startup savings
- **Subagent**: the spawn prompt never enters context unless the parent dispatches
- Corollary: `CLAUDE.md` loads **unconditionally** → keep it < 200 lines

</v-clicks>

<div v-click class="full-width text-2xl italic text-orange-400 mt-6">
Anything that can be a Skill should be one.
</div>

<!--
Callback to AI-Driven-Development "Progressive Context Disclosure" slide — there it was a
context idea; here it's a design rule you author against. Verify the 95% / Tool Search dates.
-->


---
layout: section
---

# Authoring the primitives

::subtitle::

Skills · Subagents · Hooks · MCP — each through the same lens


---
layout: default
---

# Skills — author for discovery

<v-clicks depth="2">

- A folder; only `SKILL.md` is mandatory (Markdown + optional bundled scripts)
- **Descriptive name** — found from the index
- **Scoped trigger** — a clear "when does this apply?"
- **Layered detail** — overview first, references loaded on demand
- Now a **cross-vendor standard**: Cursor, Copilot, Codex, Gemini read the same `SKILL.md`

</v-clicks>

<div v-click class="full-width text-xl italic text-orange-400 mt-6">
⚠️ Footgun — the dynamic <code>!`cmd`</code> runs <b>before</b> the model sees the skill.
Model-level defences never fire. 91% of malicious skills abuse this (ToxicSkills).
</div>

<!--
Callback: AI-Driven-Development "Skills-in-git" slide. Same file onboards a hire AND the agent.
Verify the 91% figure (Snyk ToxicSkills).
-->


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
layout: socials
---


---
layout: source
source: itenium-be/Extending-Your-Agent
---


---
layout: end
---
