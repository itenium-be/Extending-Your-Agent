Adversial Review both extensions research
=========================================

2. The two cite near-disjoint MCP toolsets — DeepResearch: MCPhound, YawLabs/mcp-compliance. Atlas: Bellwether,
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
