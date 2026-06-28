# Claude tooling for a Functional Analyst / Business Analyst / Product Owner

A research report on Claude Code & claude.ai plugins, skills, subagents, and MCP servers useful for a BA/FA/PO IT profile. Covers official (Anthropic / vendor) and community-built tools, prioritizing Jira+Confluence, Azure DevOps, and GitHub integrations.

- **Researched:** June 2026 (deep-research fan-out: 6 angles, 27 sources fetched, 25 claims adversarially verified, 24 confirmed / 1 killed).
- **Scope confirmed with requester:** stacks = Jira+Confluence, Azure DevOps, GitHub Issues/Projects; sources = official + community; output = this report + `TOP_PICKS.md`.

---

## 0. The four tool types (so the rest of the report makes sense)

| Type            | What it is                                                        | Where it lives                       | Example here            |
|-----------------|-------------------------------------------------------------------|--------------------------------------|-------------------------|
| **MCP server**  | A bridge connecting Claude to an external system's API            | Remote URL or local process          | Atlassian Rovo, ADO MCP |
| **Skill**       | A markdown know-how pack (`SKILL.md`) teaching Claude a method     | `~/.claude/skills/` or a plugin       | pm-skills, drawio-skill |
| **Subagent**    | A role-scoped persona Claude delegates a task to                  | `~/.claude/agents/*.md`               | `business-analyst`      |
| **Plugin**      | A bundle (skills + agents + MCP + commands) with 1-command install | A marketplace repo                    | claude-plugins-official |

A BA/PO toolkit usually mixes all four: an **MCP server** to reach your tracker, **skills** for the craft (PRDs, stories), and maybe a **subagent** persona.

---

## 1. Work-management & docs integrations (MCP servers)

These are the highest-leverage items — they let Claude read and write your actual backlog and documentation, not just talk about it.

### 1a. Atlassian — Jira & Confluence

| Tool                              | Official?            | Deployments               | Auth                  | Source                 |
|-----------------------------------|----------------------|---------------------------|-----------------------|------------------------|
| [Atlassian Rovo MCP][rovo]        | **Official (GA)**    | Cloud only                | OAuth 2.1 / API token | mcp.atlassian.com      |
| [sooperset/mcp-atlassian][soop]   | Community (5.5k★)     | Cloud + Server/DC         | API / Personal token  | `uvx mcp-atlassian`    |
| [mcp-atlassian-extended][ext]     | Community             | Cloud                     | API token             | GitHub                 |
| [phuc-nt/mcp-atlassian-server][phuc] | Community          | Cloud                     | API token             | GitHub                 |
| [b1ff/atlassian-dc-mcp][b1ff]     | Community             | Server / Data Center      | Personal token        | GitHub                 |

[rovo]: https://github.com/atlassian/atlassian-mcp-server
[soop]: https://github.com/sooperset/mcp-atlassian
[ext]: https://github.com/vish288/mcp-atlassian-extended
[phuc]: https://github.com/phuc-nt/mcp-atlassian-server
[b1ff]: https://github.com/b1ff/atlassian-dc-mcp

**Atlassian Rovo MCP Server** — the *official*, Atlassian-maintained, cloud-hosted server (Generally Available). Connects Claude/ChatGPT/Cursor/VS Code/Copilot to **Jira, Confluence, Jira Service Management, Bitbucket, and Compass**. For a BA/PO:
- Jira: create/update issues, search with JQL, bulk operations — all respecting your existing permissions.
- Confluence: create/edit pages, search & summarize content, navigate spaces.
- Connect via the remote endpoint `https://mcp.atlassian.com/v1/mcp/authv2` (OAuth, just-in-time install — nothing to deploy) or run locally via the `mcp-remote` proxy on Node 18+.
- **Limitation:** Cloud only.

**sooperset/mcp-atlassian** — the leading *community* server and the answer for **on-prem**. Explicitly "not an official Atlassian product," but supports Jira Server/DC (v8.14+) and Confluence Server/DC (v6.0+) **plus** Cloud — 72 tools total (JQL/CQL search, create/read/update tickets, change status, create docs, add comments). Install via `uvx mcp-atlassian`, Docker, or pip; auth via API tokens (Cloud) or Personal Access Tokens (DC). Use this if your Jira/Confluence is self-hosted, which Rovo won't reach.

> **Verification note:** an early claim that "the official marketplace contains NO Atlassian/Azure plugins" was **refuted (killed 0–3)** during research. The accurate picture: Anthropic's own marketplace doesn't ship these, but **first-party vendor MCP servers (Atlassian, Microsoft, GitHub) are official and fully available** — they're just published by the vendor, not by Anthropic.

### 1b. Azure DevOps — Boards, Work Items, Wiki (your .NET-stack fit)

| Tool                                  | Official?        | Covers                                   | Install                         |
|---------------------------------------|------------------|------------------------------------------|---------------------------------|
| [microsoft/azure-devops-mcp][ado]     | **Official (MS)**| Work items, boards, iterations, wiki, repos, pipelines, test plans | `npx @azure-devops/mcp {org}` or remote |
| [Tiberriver256/mcp-server-azure-devops][tib] | Community  | Work items, repos, PRs                    | npm                             |
| [mcp-azuredevops-bridge][bridge]      | Community        | Work item bridge                          | GitHub                          |
| [jaybird-us/azure-devops-mcp][jay]    | Community        | Boards/work items                         | GitHub                          |

[ado]: https://github.com/microsoft/azure-devops-mcp
[tib]: https://github.com/Tiberriver256/mcp-server-azure-devops
[bridge]: https://github.com/krishh-amilineni/mcp-azuredevops-bridge
[jay]: https://github.com/jaybird-us/azure-devops-mcp

**microsoft/azure-devops-mcp** — *official Microsoft*, MIT-licensed. Remote-first onboarding (`https://mcp.dev.azure.com/{organization}` via `.vscode/mcp.json`) or local stdio (`npx @azure-devops/mcp {org-name}`). Browser-based MS account login on first use, optional Azure CLI auth. BA/PO-relevant domains:
- **Work Items & Boards:** list/manage work items, iterations, team info — e.g. *"List my work items for project 'Contoso'."*
- **Wikis:** create/update/retrieve pages — e.g. *"Create a wiki page '/Architecture/Overview' with this content."*
- Also repos, pipelines, test plans, advanced security.

This is the natural first integration given your Microsoft/.NET stack. Community alternatives (Tiberriver256 et al.) predate the official one and can be dropped in its favor unless you need a niche behavior.

### 1c. GitHub — Issues & Projects

**[github/github-mcp-server][ghmcp]** — *official GitHub*. Remote hosted (1-click install for VS Code / Visual Studio) or local Docker (`ghcr.io/github/github-mcp-server`); OAuth (recommended) or PAT, with `GITHUB_HOST` for Enterprise. BA/PO-relevant:
- **Issues:** create/read/update with custom fields, labels, milestones, **sub-issues**, comments; search/filter by state/label/date.
- **Projects:** create & manage Projects, add/update items, configure iteration & status fields, query project data.
- PRs and code search round it out.

Use it if your backlog lives in GitHub Issues/Projects.

[ghmcp]: https://github.com/github/github-mcp-server

---

## 2. BA / PO skill packs (the craft: PRDs, stories, discovery)

These teach Claude *how* to produce BA/PO artifacts to a real standard. Both install as Claude Code plugin marketplaces.

### 2a. phuryn/pm-skills — *recommended*

[github.com/phuryn/pm-skills][pm] — **68+ skills across 9 plugins**, 21.4k★, MIT. Encodes named frameworks (Teresa Torres, Marty Cagan, Alberto Savoia) as guided workflows rather than generic text. Domains:

| Domain         | Count | BA/PO examples                                                            |
|----------------|-------|---------------------------------------------------------------------------|
| Discovery      | 13    | assumption mapping, prioritization, opportunity-solution trees, interview scripts |
| Strategy       | 12    | product vision, Lean Canvas / BMC, SWOT, Porter's Five Forces             |
| Execution      | 16    | **PRDs, user stories, OKRs, sprint planning, stakeholder mapping, pre-mortems** |
| Market research| 7     | personas, journey mapping, segmentation, TAM/SAM/SOM                       |
| Growth & GTM   | 11    | ICPs, positioning, North Star metrics, battlecards                        |
| Analytics      | 3     | SQL generation, cohort analysis, A/B test analysis                        |
| Utilities      | 6     | NDAs, privacy policies, grammar                                           |

Install:
```
claude plugin marketplace add phuryn/pm-skills
claude plugin install pm-toolkit@pm-skills
```
Works in Claude Code, Claude Cowork, Codex (skills only, no slash-commands), and copy-paste into `.gemini/skills/` etc.

[pm]: https://github.com/phuryn/pm-skills

### 2b. deanpeters/Product-Manager-Skills

[github.com/deanpeters/Product-Manager-Skills][dp] — **52 PM frameworks** as `SKILL.md` packs, CC BY-NC-SA, actively maintained (v0.80, June 2026 added stakeholder identification & mapping). Three tiers: 6 end-to-end **workflows** (discovery cycles, roadmap planning, PRD development), 23 **interactive** tools (prioritization advisors, stakeholder engagement, growth diagnostics), 23 **component** templates (**user stories with acceptance criteria**, positioning statements, **epic breakdowns**). Includes a Streamlit playground to test skills in-browser.

Install (Claude Code): `claude /plugin marketplace add deanpeters/Product-Manager-Skills`. For Claude Desktop/Web: download themed ZIP packs and upload individual skills.

[dp]: https://github.com/deanpeters/Product-Manager-Skills

### 2c. BMAD Business Analyst skill

[BMAD business-analyst skill][bmad] — part of the BMAD-method agent framework, packaged as a standalone Claude Code skill focused specifically on the **business-analyst** role (requirements elicitation, project briefs). Narrower than the two packs above; worth a look if you want a single dedicated BA persona rather than a broad PM library.

[bmad]: https://agentskills.so/skills/aj-geddes-claude-code-bmad-skills-business-analyst

---

## 3. Subagents (role personas Claude delegates to)

**[VoltAgent/awesome-claude-code-subagents][va]** — 154+ subagents; category **08. Business & Product** is directly relevant:

| Subagent            | Role                                          |
|---------------------|-----------------------------------------------|
| `business-analyst`  | Requirements specialist                       |
| `product-manager`   | Product strategy expert                        |
| `backlog-grooming`  | Agile backlog refinement specialist           |
| `assumption-mapping`| Product assumption risk & validation specialist|
| `ux-researcher`     | User research expert                          |
| `project-manager`   | Project management specialist                 |
| `scrum-master`      | Agile ceremony / process facilitation         |

Install: copy agent files to `~/.claude/agents/` (global) or `.claude/agents/` (project), or use the repo's `./install-agents.sh` interactive installer, or the plugin marketplace. A subagent is a lighter touch than a skill pack — it shapes *who* Claude acts as for a task, not the framework it follows. Pair a `business-analyst` subagent with a pm-skills skill for both.

[va]: https://github.com/VoltAgent/awesome-claude-code-subagents

---

## 4. Diagramming (BPMN, flowcharts, ERD, sequence, C4)

| Tool                         | Type        | Strength                                              | Install                          |
|------------------------------|-------------|-------------------------------------------------------|----------------------------------|
| [Agents365-ai/drawio-skill][draw] | Skill   | **draw.io** files (BPMN, flowchart, ERD, UML, arch); 10k+ shapes; exports PNG/SVG/PDF | `npx skills add Agents365-ai/365-skills -g` |
| [veelenga/claude-mermaid][mer]    | MCP+skill | **Mermaid** with live browser reload; SVG/PNG/PDF; themes | `/plugin marketplace add veelenga/claude-mermaid` |
| [Agents365-ai/mermaid-skill][mskill] | Skill  | Mermaid diagrams as a pure skill (no MCP)             | `npx skills add`                 |

[draw]: https://github.com/Agents365-ai/drawio-skill
[mer]: https://github.com/veelenga/claude-mermaid
[mskill]: https://github.com/Agents365-ai/mermaid-skill

**drawio-skill** — natural-language → draw.io diagrams with 6 presets (ERD, UML class, sequence, architecture, ML, flowchart), access to 10,000+ official draw.io shapes (AWS/Azure/GCP/K8s icons), and a self-checking loop that reads its own PNG output to fix overlaps/clipped labels (up to 2 rounds). Best when you need **editable stakeholder diagrams** in a tool BAs already use (draw.io). Requires the draw.io desktop CLI installed locally. Cross-platform (Claude Code, Cursor, Copilot).

**claude-mermaid** — an MCP server *with a built-in skill* for Mermaid diagrams, featuring **live reload** (browser preview updates as Claude edits), themes, and multi-format export. Best when you want **diagrams-as-code** that drop straight into a wiki/Confluence/markdown spec. Install via plugin (`/plugin marketplace add veelenga/claude-mermaid` then `/plugin install claude-mermaid@claude-mermaid`) or `npm install -g claude-mermaid`.

*Choosing:* draw.io for polished, editable, shape-rich diagrams handed to business stakeholders; Mermaid for fast, versionable, text-based diagrams that live next to your specs.

---

## 5. Document reading & summarization

**[jztan/pdf-mcp][pdf]** — an MCP server for reading/extracting/summarizing **PDF** content, useful for digesting vendor docs, RFPs, regulatory specs, and stakeholder decks into requirements. Claude.ai and Claude Desktop also natively handle uploaded PDFs/DOCX, so an MCP server is mainly worth it for **bulk or programmatic** document workflows.

For everyday "summarize this spec / extract the requirements" work, the built-in file upload in claude.ai or the Claude Code `Read` tool already covers most needs — reach for a dedicated MCP server only when you're processing documents at volume or from a repository/drive.

[pdf]: https://github.com/jztan/pdf-mcp

---

## 6. Where to discover & install more

| Directory                                    | What it is                                          |
|----------------------------------------------|-----------------------------------------------------|
| [anthropics/claude-plugins-official][cpo]    | Anthropic's curated plugin directory (31k★); `/plugin > Discover` in Claude Code |
| [modelcontextprotocol/servers][mcps]         | The canonical MCP server reference list (official + community) |
| [mcpservers.org][mcporg]                     | Browsable MCP server catalog                        |
| [win4r/Awesome-Claude-MCP-Servers][win4r]    | Community "awesome" list of Claude MCP servers      |

[cpo]: https://github.com/anthropics/claude-plugins-official
[mcps]: https://github.com/modelcontextprotocol/servers
[mcporg]: https://mcpservers.org/
[win4r]: https://github.com/win4r/Awesome-Claude-MCP-Servers

**Installing, in short:**
- **MCP server (remote):** add the vendor URL to your client config / approve OAuth — nothing to deploy (Rovo, GitHub remote, ADO remote).
- **MCP server (local):** `npx`/`uvx`/Docker per the repo, with a token in an env var.
- **Plugin / skill pack:** `claude plugin marketplace add <owner/repo>` then `claude plugin install <plugin>@<marketplace>`.
- **Subagent:** drop the `.md` into `~/.claude/agents/` (global) or `.claude/agents/` (project).

---

## 7. Recommended starter setup for your profile

1. **Tracker MCP** — Azure DevOps MCP (your stack) and/or Atlassian Rovo (Cloud) or sooperset/mcp-atlassian (on-prem). *Highest leverage — Claude now acts on your real backlog & wiki.*
2. **One skill pack** — phuryn/pm-skills for breadth (PRDs, stories, OKRs, discovery).
3. **One diagram tool** — drawio-skill (stakeholder diagrams) or claude-mermaid (specs-as-code).
4. *(Optional)* `business-analyst` subagent from VoltAgent for a dedicated BA persona.

---

## 8. Caveats

- **"Official" is split.** Anthropic's marketplace doesn't ship Jira/ADO/GitHub plugins, but the **vendors' own MCP servers are official** (Atlassian Rovo, Microsoft ADO, GitHub). Don't equate "not in Anthropic's marketplace" with "not official."
- **Cloud vs on-prem matters.** Atlassian Rovo is **Cloud only**; for Server/Data Center use sooperset/mcp-atlassian.
- **Trust before install.** Anthropic doesn't vet third-party plugin/MCP code. Review any community server's repo and scope its token/permissions before connecting it to corporate systems.
- **Licensing.** pm-skills = MIT; Product-Manager-Skills = CC BY-NC-SA 4.0 (non-commercial attribution-share-alike — fine for internal use, check before redistribution).
- **Research limitation.** The deep-research run's synthesis stage returned placeholder findings; this report was reconstructed from the run's **verified source set** (27 sources, 24 confirmed claims) by directly fetching and quoting each primary source. Star counts and version numbers are as reported by those sources in June 2026 and drift over time.

---

## Sources

Primary (vendor/repo) sources fetched and quoted:

- Atlassian Rovo MCP — https://github.com/atlassian/atlassian-mcp-server
- sooperset/mcp-atlassian — https://github.com/sooperset/mcp-atlassian
- mcp-atlassian-extended — https://github.com/vish288/mcp-atlassian-extended
- phuc-nt/mcp-atlassian-server — https://github.com/phuc-nt/mcp-atlassian-server
- b1ff/atlassian-dc-mcp — https://github.com/b1ff/atlassian-dc-mcp
- microsoft/azure-devops-mcp — https://github.com/microsoft/azure-devops-mcp
- Azure DevOps MCP docs — https://learn.microsoft.com/en-us/azure/devops/mcp-server/mcp-server-overview
- Tiberriver256/mcp-server-azure-devops — https://github.com/Tiberriver256/mcp-server-azure-devops
- mcp-azuredevops-bridge — https://github.com/krishh-amilineni/mcp-azuredevops-bridge
- jaybird-us/azure-devops-mcp — https://github.com/jaybird-us/azure-devops-mcp
- github/github-mcp-server — https://github.com/github/github-mcp-server
- phuryn/pm-skills — https://github.com/phuryn/pm-skills
- deanpeters/Product-Manager-Skills — https://github.com/deanpeters/Product-Manager-Skills
- BMAD business-analyst skill — https://agentskills.so/skills/aj-geddes-claude-code-bmad-skills-business-analyst
- VoltAgent/awesome-claude-code-subagents — https://github.com/VoltAgent/awesome-claude-code-subagents
- Agents365-ai/drawio-skill — https://github.com/Agents365-ai/drawio-skill
- Agents365-ai/mermaid-skill — https://github.com/Agents365-ai/mermaid-skill
- veelenga/claude-mermaid — https://github.com/veelenga/claude-mermaid
- jztan/pdf-mcp — https://github.com/jztan/pdf-mcp
- anthropics/claude-plugins-official — https://github.com/anthropics/claude-plugins-official
- modelcontextprotocol/servers — https://github.com/modelcontextprotocol/servers
- mcpservers.org — https://mcpservers.org/
- win4r/Awesome-Claude-MCP-Servers — https://github.com/win4r/Awesome-Claude-MCP-Servers
