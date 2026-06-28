# Marketplaces & Extension Ecosystems Across AI Coding Tools

*Researched 2026-06-28. This space moves weekly — several products are mid-rebrand or mid-deprecation (flagged inline).*

## Mental model: two layers

Separate **what plugs in** (protocol) from **how you get it** (distribution):

- **Protocol → converged on MCP.** Within ~13 months of Anthropic's Nov-2024 launch, every major tool adopted the Model Context Protocol as its interop layer. Donated to the Linux Foundation's Agentic AI Foundation (2025-12-09), co-founded by Anthropic, Block, and OpenAI. The "unit of extension" is collapsing toward "an MCP server."
- **Distribution → still fragmented** into three camps (see synthesis below).

## Comparison table

| Tool          | Marketplace? (type)                                    | Unit of extension                              | MCP support          | Distribution model                       |
|---------------|--------------------------------------------------------|------------------------------------------------|----------------------|------------------------------------------|
| **Claude Code** | git-repo marketplaces + official auto-added one      | **plugin** (skills+agents+hooks+commands+MCP+LSP) | client; bundled      | decentralized git + light curation       |
| **Codex CLI** | `marketplace.json` catalogs; central directory "soon" | **plugin** (skills+hooks+MCP) + AGENTS.md + TOML subagents | client **and** server | decentralized git; central registry unreleased |
| **Cursor**    | **two**: Open VSX + first-party Cursor Marketplace     | VS Code extension; rule `.mdc`; **plugin** bundle | first-class, one-click | hybrid (open + curated + git + community) |
| **Windsurf**  | Open VSX + built-in **MCP Marketplace** (one-click)    | VSIX extension; MCP server; rule/workflow `.md` | first-class, deeplinks | Open VSX + curated MCP store + git        |
| **Copilot**   | VS Code Marketplace + **GitHub MCP Registry**          | MCP server (old GitHub-App exts sunset 2025-11-10) | broad, cross-IDE     | centralized discovery over open protocol  |
| **Gemini CLI**| discovery **gallery** (unvetted, star-ranked)          | git-repo **extension bundle** (`gemini-extension.json`) | client; in settings  | decentralized git; gallery only indexes   |
| **Continue.dev** | **Continue Hub** (hosted central registry)          | typed **blocks** (models/rules/MCP/docs/prompts) | native block type    | centralized hosted registry               |
| **Cline**     | **MCP Marketplace** (curated, one-click)               | **MCP server** only                            | core to product      | centralized + curated                     |
| **Zed**       | extension registry (zed.dev/extensions)                | **extension** (can bundle MCP "context servers") | native               | central registry + custom config          |
| **Aider**     | **none**                                               | config/convention files only                   | **none native**      | local config files only                   |

## Per-tool notes

**Claude Code (baseline).** Plugins are git-repo "marketplaces" added via `/plugin marketplace add owner/repo`. Each plugin bundles the widest set of primitives — skills, agents/subagents, hooks, slash commands, MCP servers, and (uniquely) **LSP servers**. Official marketplace auto-added on startup. Managed allow/deny via `strictKnownMarketplaces` (allowlist) and `blockedMarketplaces` (denylist).

**OpenAI Codex / Codex CLI.** Went config-only → real plugin system in 2026 (plugins launched 2026-03-25). A "marketplace" is a `marketplace.json` catalog pointing at git repos/local paths; the official central public directory is *"coming soon"* (not shipped). A plugin (`.codex-plugin/plugin.json`) bundles skills (agentskills.io spec), hooks, MCP servers, app integrations; lower layers (`config.toml`, layered `AGENTS.md`, TOML subagents) persist. MCP is bidirectional — client *and* server (`codex mcp-server`). Custom prompts deprecated 2026-01-22 in favor of skills. Docs: developers.openai.com/codex/plugins.

**Cursor.** VS Code fork; uses **Open VSX** (barred from MS Marketplace by ToS) + first-party Anysphere replacements. Rules are `.cursor/rules/*.mdc` (git-shareable). MCP via `.cursor/mcp.json` with one-click "Add to Cursor" deep links. Launched a first-party **plugin Marketplace** (cursor.com/marketplace, github.com/cursor/plugins) whose bundle — *"plugins package skills, subagents, MCP servers, hooks, and rules into a single install"* (install via `/add-plugin`, `.cursor-plugin/plugin.json`) — is a near-direct copy of Claude Code's model. **cursor.directory** is a separate community web directory.

**Windsurf (Cascade).** Now owned by **Cognition** (acquired July 2025); docs redirect to docs.devin.ai, IDE folding into "Devin Desktop" (rename in progress). VS Code fork on Open VSX. Rules/Workflows are `.md` files (`.windsurf/rules/`, `.windsurf/workflows/`) + copy-paste Rules Directory. Standout: built-in **MCP Marketplace/Plugins store** with one-click install, official-server checkmarks, `windsurf://` deeplinks, 100-tool cap, enterprise allowlist/custom-registry support.

**GitHub Copilot.** Clearest "MCP pivot": proprietary GitHub-App-style Copilot Extensions **sunset 2025-11-10**, explicitly replaced with MCP. Client-side VS Code chat extensions (Chat API participants) remain supported. MCP went **GA in VS Code 1.102 (July 2025)**, cross-IDE. Centralized **GitHub MCP Registry** (launched 2025-09-16, still public preview), one-click install, enterprise internal-registry/allowlist controls.

**Gemini CLI (Google).** Extensions framework launched 2025-10-08. Unit is a git repo with `gemini-extension.json` bundling MCP servers, TOML slash commands, `GEMINI.md` context, `excludeTools` policy, (newer) skills/hooks/subagents. Centralized discovery **gallery** (geminicli.com/extensions, ~1,000+ listings) but explicitly **unvetted** — install is `gemini extensions install <repo-url>`, so distribution is decentralized git.

**Continue.dev.** **Continue Hub** (hub.continue.dev) is the most "app-store"-like: centralized hosted registry of typed **blocks** (Models, Rules, Context, Docs, MCP Servers, Prompts, Data) composed into Assistants via `config.yaml`. MCP is a native block type (incl. Docker MCP). Account-based publishing, not git-repo-per-extension.

**Cline.** Built-in **MCP Marketplace** (Feb 2025) — purely an MCP-server app store: one-click install with auto clone/setup/dependency/credential handling. Curated centrally; submissions via GitHub issues to `cline/mcp-marketplace`.

**Zed.** Official **extension registry** (zed.dev/extensions); extensions can bundle MCP servers surfaced as "context servers" in the Agent Panel.

**Aider.** The outlier: no plugin system, no marketplace, **no native MCP** (through ~v0.86.x, mid-2026; MCP is an open RFC). Customization via `.aider.conf.yml`, CLI flags, env vars, `CONVENTIONS.md`. Only community wrappers expose Aider *as* an MCP server.

## Synthesis: convergence on MCP, divergence on marketplaces

**MCP has won as the interop layer.** Adopted as a client by OpenAI (Mar 2025), Google, Microsoft/GitHub, Cursor, Windsurf, Cline, Zed, Continue — with Aider the lone holdout. Multi-vendor governance under the Linux Foundation. An official MCP Registry (registry.modelcontextprotocol.io) exists but is **preview, not GA** as of June 2026, designed to feed aggregators (PulseMCP, Glama, mcp.so, Smithery, Docker MCP Catalog). Complemented (not challenged) by **A2A** (agent-to-agent; different scope).

**Marketplace models remain fragmented along three axes:**

1. **Open VSX (VS Code-fork editors).** Cursor and Windsurf, barred from Microsoft's Marketplace by ToS, both standardized on Eclipse's Open VSX for editor extensions — shared by necessity, not coordination.
2. **Git-repo bundles (decentralized).** Claude Code, Codex CLI, Gemini CLI distribute via git repos + manifest, indexed by thin/optional central catalogs. **Codex and Cursor both cloned Claude Code's exact bundle concept** — one plugin packaging skills + subagents + hooks + commands + MCP — making the Claude Code plugin a *de facto template* others copy, even as central directories lag.
3. **Centralized curated registries.** Continue Hub, Cline's MCP Marketplace, GitHub's MCP Registry, Windsurf's MCP store, Zed's registry — one-click, vetted, the model enterprises prefer (allowlists, internal registries).

**Bottom line.** The protocol layer consolidated around MCP; the distribution layer did not. The fault line is **curated central registry** (Continue, Cline, GitHub, Windsurf, Zed) **vs. decentralized git-repo plugins** (Claude Code, Codex, Gemini). Claude Code sits on the decentralized-git side, differentiating by bundling the widest set of primitives (incl. the only **LSP** slot) and by managed-policy controls most competitors are only now matching via enterprise MCP allowlists.

## Flags / uncertainties

- **Gemini CLI** mid-deprecation into Antigravity CLI (announced 2026-05-19; consumer tiers cut off ~2026-06-18); ecosystem persists but rebranding.
- **Windsurf** mid-merger into Cognition's "Devin Desktop"; brand retirement not formally confirmed.
- **Codex** central public plugin directory announced but not yet shipped.
- **Official MCP Registry** and **GitHub MCP Registry** both still preview, no confirmed GA date.
- **Cursor** plugin-marketplace exact versioning fuzzy (~v2.5–v3.9, June 2026); marketplace itself verified real.
- MCP server counts across third-party directories vary wildly by source — treat as approximate snapshots.
