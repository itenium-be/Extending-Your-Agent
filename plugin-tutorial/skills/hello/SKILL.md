---
# Invoke the /greeter in Claude if not yet done!


# Without a name this is triggered as: /extending-your-agent-tutorial:hello
name: greeter

# Due disable-model-invocation this skill is only activated on command
description: Greet the user with a friendly message
disable-model-invocation: true
# user-invocable: false -> for a skill that doesn't make sense to be invoked manually

# Don't take current context into account (only CLAUDE.md)
context: fork
# agent: which agent to use for the fork? (built-in: Explore, Plan -- these two skip injecting CLAUDE.md)

# Placeholder for $ARGUMENTS
argument-hint: "[help-working-on]"
# Argument Aliases: $0, $help-working-on
# Escape an actual $ as \$
# Special Variables:
# - ${CLAUDE_EFFORT}: if you want the skill to work differently depending on current effort level
# - ${CLAUDE_SKILL_DIR}: to reference scripts packages with this skill


# And then a whole bunch of others:
# https://code.claude.com/docs/en/skills#frontmatter-reference
# allowed-tools / disallowed-tools: Bash(git add *)
# model: haiku -> fable
# effort: low, medium, high, xhigh, max
# shell: bash / powershell (PowerShell? CLAUDE_CODE_USE_POWERSHELL_TOOL=1)
# paths: only activate this skill when on one of these path(s)


# For the fancy ASCII we're using an external dependency, see:
# marketplace.json: allowCrossMarketplaceDependenciesOn
# plugin.json: dependencies
---

Log your reasoning to ${CLAUDE_SKILL_DIR}/logs/${CLAUDE_SESSION_ID}.log and log the full path.

The **last** line you append MUST be a status marker the `greeter-log` monitor watches for:
- `[done] <one-line summary>` on success
- `[error] <what failed>` if the greeting could not be produced

## Current user

The current user is

!`whoami`


## Current environment

```!
node -v
npm -v
git --version
```

## The Greeting

Greet the "Current user" warmly and ask how you can help them with "$ARGUMENTS" today.
Shortly state their current environment.

Render the banner with the **figlet-text-converter** skill (a plugin dependency — see
`.claude-plugin/plugin.json` `dependencies`): use it to turn the user's name into big FIGlet ASCII letters.
Then make it awesome — wrap the banner in a rainbow and add a unicorn (and friends 🦄🌈✨).
