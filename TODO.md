┌──────────────────┬──────────────────────────────────────────────────────────────────┐
│     Category     │                         Keys (examples)                          │
├──────────────────┼──────────────────────────────────────────────────────────────────┤
│                  │ run commands on lifecycle events — PreToolUse, PostToolUse,      │
│ Hooks ⭐         │ Stop, SessionStart, … (types:                                    │
│                  │ command/prompt/agent/http/mcp_tool)                              │
├──────────────────┼──────────────────────────────────────────────────────────────────┤
│ MCP              │ enableAllProjectMcpServers, enabled/disabledMcpjsonServers,      │
│                  │ allowed/deniedMcpServers, disableClaudeAiConnectors              │
├──────────────────┼──────────────────────────────────────────────────────────────────┤
│ Plugins /        │ enabledPlugins, ,                          │
│ marketplaces     │ pluginConfigs                        │
├──────────────────┼──────────────────────────────────────────────────────────────────┤
│ Skills           │ skillOverrides, disableBundledSkills, skillListingMaxDescChars   │
└──────────────────┴──────────────────────────────────────────────────────────────────┘



/agents







https://github.com/affaan-m/ECC


- [10x-Team](https://github.com/Jaan-Mustafa/10x-Team): 12 specialized roles (CTO, Product Manager, Security Engineer, ...)
- [16minds](https://github.com/yukurash/16minds-plugin)
- [ADR Creator](https://github.com/barnburner121/claude-plugin-marketplace)



Hooks:
SessionStart:
https://github.com/obra/superpowers/blob/main/skills/using-superpowers/SKILL.md



https://edotor.net/?engine=dot#deflate:eNqVU8FKw0AQvfsVQ0CqoAevlipFED14EXoqQTa702bpZmbZ3dQG8d9NmlaDZtO45/fezM57T+m1EzYHv9HGvK0Mv8PHGdQvWXh0UKD3Yo3gUKLeokpg6XNhcaa4zAxK7aTBdNoy5hmXAQIDUqi51giCghXeD7OMQ6EqyJzQ5AO7AlWHoUXBpI7gZ9ryBjtYTet2929Gxrsj+kWv8wCCqhYCwlpTndIOOcYV50RcksRbmCx8M3u5h6bNr5e2dJY9ppM+5pPwIHOUG6N9iO7wUN8iIIhaTzHY+oo6YNGn98imMav9GO6EDKbqw72it/UAuNAkTamanaURTq+0FEEz+cuYOydNvb6LuTdsbcMbNNKIDM0sIU7S00pRkw8qFfpkTHwGtI63iFRikDkYxM4lurH72fwKcIsEN+dJOkJqlNcHcYUrTXW4TAXEIYmXYO/yuNj/sySN8q9aRMrSIKPV6PG5jx8pzN+sxQZFRaZnn1++6LmD



Adversial Review both extensions research
=========================================

1. The two cite near-disjoint MCP toolsets — DeepResearch: MCPhound, YawLabs/mcp-compliance. Atlas: Bellwether,
  modelcontextprotocol/conformance, FastMCP, pinner-mcp. Non-overlap on the same problem means at least one set is partly hallucinated.
  Independently verify before any goes on a slide: MCPhound, mcp-compliance, Bellwether (⭐1, "days old"), CVE-2025-54136/MCPoison, the
  "Snyk acquired Invariant 2025-06-24" date (suspiciously equals the research date −1yr).


┌─────────────────────┬───────────────────────────────┬──────────────────────────────────────────────────────────────────────────────┐
│      Dimension      │        DeepResearch.md        │                                 Atlas (dir)                                  │
├─────────────────────┼───────────────────────────────┼──────────────────────────────────────────────────────────────────────────────┤
│ Hooks track         │ Absent                        │ Full doc (the one fully-deterministic surface)                               │
├─────────────────────┼───────────────────────────────┼──────────────────────────────────────────────────────────────────────────────┤
│ Skill testing       │ MLflow only; misses           │ skill-creator + baseline + MLflow — correct primary                          │
│                     │ skill-creator                 │                                                                              │
├─────────────────────┼───────────────────────────────┼──────────────────────────────────────────────────────────────────────────────┤
│ Subagent routing    │ --agents/@mention/NL only     │ + promptfoo provider, headless stream-json, parent_tool_use_id, Task→Agent   │
│                     │                               │ rename, issue #17591                                                         │
├─────────────────────┼───────────────────────────────┼──────────────────────────────────────────────────────────────────────────────┤
│ MCP/rug-pull        │ 1 CVE (MCPoison/Cursor)       │ postmark-mcp, mcp-remote, Smithery, hook-RCE, ToxicSkills, Sigstore bypass + │
│ incidents           │                               │  incident table                                                              │
├─────────────────────┼───────────────────────────────┼──────────────────────────────────────────────────────────────────────────────┤
│ Actionability       │ Stack list                    │ Copy-paste Actions YAML, jq, schemas, priority-ordered floor                 │
├─────────────────────┼───────────────────────────────┼──────────────────────────────────────────────────────────────────────────────┤
│ Talk packaging      │ Slide-ready takeaways, punchy │ Per-doc TL;DRs, no single slide section                                      │
├─────────────────────┼───────────────────────────────┼──────────────────────────────────────────────────────────────────────────────┤
│ Depth               │ ~140 lines                    │ ~590 lines, 5 focused docs                                                   │
└─────────────────────┴───────────────────────────────┴─────────────────────────────────────────────────────────────────────────────

Use Atlas as the body of the talk. Steal two things from DeepResearch: its "Slide-ready takeaways" structure and the line "plugins you can regression-test; skills and routing you mostly smoke-test and pray" — that's the thesis, and Atlas buries it. Then fix the pulser contradiction and fact-check the divergent tool/CVE claims in flag #2.
