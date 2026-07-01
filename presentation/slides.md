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
  - <s>MCP & LSP</s>
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
h1:
  type: brackets
  color: muted
  position: all
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


<!--
Examples?
- [10x-Team](https://github.com/Jaan-Mustafa/10x-Team): 12 specialized roles (CTO, Product Manager, Security Engineer, ...)
- [16minds](https://github.com/yukurash/16minds-plugin)
-->


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
h1:
  type: dot
  color: primary
  position: end
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
h1:
  type: slashes
  color: primary
  position: end
h2:
  type: semicolon
  color: muted
  position: end
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
h1:
  type: braces
  color: muted
  position: all
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
layout: break
---

::timer::

<Timer :minutes="5" />


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
h1:
  type: hash
  color: primary
  position: start
h2:
  type: dot
  color: muted
  position: end
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
background: agents.jpg
---

# Agents

::subtitle::

Separate instructions & context, summary back


---
layout: default-aside
h1:
  type: brackets
  color: primary
  position: 2
---

# Default agents

<VClickTable
  :headers="['Agent', 'Writes?', 'Prompt', 'Used for']"
  :rows="[
    ['<b>claude</b>', '✅', '<code>system</code>', 'Default — when no agent is named'],
    ['<b>general-purpose</b>', '✅', '<code>system</code>', 'Open-ended multi-step research + execution'],
    ['<b>Explore</b>', '❌', '<code>custom</code>', 'Haiku: Fan-out search, returns conclusions'],
    ['<b>Plan</b>', '❌', '<code>custom</code>', 'Design implementation plans, architecture'],
  ]"
  :firstVisible="1"
  size="sm"
/>


<!--
Other defaults:
- statusline-setup (Sonnet): after `/statusline`
- claude-code-guide (Haiku): when asking about Claude Code features
-->

::image::

![](./images/default-agents.jpg)


---
layout: default-aside
---

# Subagents
## Fresh context — returns a **summary**

<v-clicks depth="2">

- Separate context window, parallel fan-out
- The **description = the dispatch decision**
- An agent starts the context with its own prompt, not the default system prompt
- Use for: noisy reads, multi-perspective review, independent work
- `/agents`: see active and available agents

</v-clicks>


<div v-click class="full-width text-2xl italic text-orange-400 mt-16">
Let's look at our amazing tutorial agents
</div>

<!--
Let's look at agents/house-style.md -> Takes over the default system prompt  
And extend-advisor -> tells us whether something should be a skill, hook etc
-->

::image::

![](./images/subagents.jpg)


---
layout: section
background: hooks.jpg
---

# Hooks

::subtitle::

Finally, determinism


---
layout: default
h1:
  type: braces
  color: primary
  position: all
---

# Hooks
## Fired on lifecycle events, invoked by the harness

<v-clicks depth="2">

- 20+ events:
  - Once per session: `SessionStart`, `SessionEnd`
  - Once per turn: `UserPromptSubmit`, `Stop`, `StopFailure`
  - On every tool call: `PreToolUse`, `PermissionRequest`, `PostToolUse`, `PostToolUseFailure`
  - `SubagentStart`, `TaskCompleted`, `ConfigChange`, `PreCompact`, `Notification`
- `/hooks`: see active hooks

</v-clicks>

<div v-click class="full-width text-2xl italic text-orange-400 mt-16">
Use for guardrails & backpressure: format-on-write, run the linter, ...
</div>


<!--
Check our JSON validator hook!


PreToolUse: block the tool with exit code 2 (1 is a non-blocking error)
-> return {hookSpecificOutput: x} with reason etc via stdout
-> continue, stopReason, suppressOutput, systemMessage, terminalSequence (https://code.claude.com/docs/en/hooks#emit-terminal-notifications)
-> additionalContext

Inside a script: `COMMAND=$(jq -r '.tool_input.command')`
-> session_id, prompt_id, cwd, effort, transcript_path, permission_mode, hook_event_name
-> for subagent: agent_id, agent_type


Matcher is a regex

Hook types: command, http, mcp_tool, prompt, agent
Other props:
- command: use ${CLAUDE_PROJECT_DIR}, CLAUDE_PLUGIN_ROOT, CLAUDE_PLUGIN_DATA (persistent data dir)
- shell: bash | powershell
- timeout: nr
- async: true (only for type=command) (also: asyncRewake)
- if: "Bash(rm *)"
- args: [] passed to the command
- once: run once per session
- statusMessage: custom spinner message

Types:
- http: JSON POST with url, headers {Authorization: 'Bearer $MY_TOKEN'}, allowedEnvVars ["MY_TOKEN"]
- mcp_tool: server, tool, input {x: "y"}
- prompt: prompt, model (default: haiku); respond with {ok: bool, reason: string}
- agent: experimental, maxTurns: 50, same response as prompt, tools: Read,Grep,Glob

A skill can define hooks in frontmatter

Also see hooks-lifecycle.svg
-->


---
layout: default
disabled: true
---

# Hooks
## Input on stdin, control via exit code or JSON

<v-clicks depth="2">

- **In** — the harness pipes JSON on stdin
  - `COMMAND=$(jq -r '.tool_input.command')`
  - `session_id`, `cwd`, `permission_mode`, `hook_event_name`, `transcript_path`, `effort`
  - subagents also get `agent_id`, `agent_type`
- **Block** — exit code `2` blocks the tool <small>(`1` = non-blocking error)</small>
- **Or** — emit JSON on stdout for richer control
  - `hookSpecificOutput.additionalContext` — inject context / reason
  - `continue`, `stopReason` — stop the turn
  - `suppressOutput`, `systemMessage`, `terminalSequence`

</v-clicks>


---
layout: default
---

# Hooks
## Five types

<VClickTable
  :headers="['Type', 'Runs', 'Key props']"
  :rows="[
    ['<b>command</b>', 'A script (bash / powershell)', '<code>args</code>, <code>timeout</code>, <code>async</code>, env vars'],
    ['<b>http</b>', 'POST JSON to a URL', '<code>url</code>, <code>headers</code>, <code>allowedEnvVars</code>'],
    ['<b>mcp_tool</b>', 'Call an MCP server tool', '<code>server</code>, <code>tool</code>, <code>input</code>'],
    ['<b>prompt</b>', 'Ask an LLM <small>(haiku)</small>', 'returns <code>{ ok, reason }</code>'],
    ['<b>agent</b>', 'Mini-agent <small>(experimental)</small>', '<code>maxTurns</code>, tools: Read/Grep/Glob'],
  ]"
  :firstVisible="1"
  size="sm"
/>

<div v-click="5" class="full-width text-2xl italic text-orange-400 mt-16">
Let's have a look at the hooks in our plugin
</div>



---
layout: default
disabled: true
---

# Hooks
## Wiring & knobs

<v-clicks depth="2">

- `matcher` is a **regex** — add `if: "Bash(rm *)"` for finer gating
- `once` — run once per session
- `async: true` — don't block <small>(command hooks only; also `asyncRewake`)</small>
- `timeout`, `statusMessage` <small>(custom spinner text)</small>
- `command` env: `${CLAUDE_PROJECT_DIR}`, `CLAUDE_PLUGIN_ROOT`, `CLAUDE_PLUGIN_DATA`
- A **skill** can declare hooks in its frontmatter

</v-clicks>


---
layout: section
background: wrapping-up.jpg
---

# Wrapping up



---
layout: code
code-size: 1.2em
---

# MCP
## October's Session

```python
from fastmcp import FastMCP

mcp = FastMCP("itenium-tool")

@mcp.tool()
def lookup(ticket_id: str) -> dict:
    """Fetch an itenium ticket by id."""
    return client.get(ticket_id)

mcp.run()
```


---
layout: full
---

<VibesArsenal />


---
layout: full
---

<CtaQuests />

---
layout: full
---

<CtaJoin />


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
