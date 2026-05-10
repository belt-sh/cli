# skills

skills are reusable agent workflows — instructions, steps, and context that help agents accomplish specific tasks.

## finding skills

```bash
# search the registry
belt skill search "image generation"
belt skill search "deployment"
belt skill search "testing"

# browse featured
belt skill store --featured

# get details
belt skill get namespace/skill-name
```

## using skills (on-demand)

`belt skill use` fetches a skill and outputs it to stdout — no local install, keeps your system clean. the agent consumes it directly.

```bash
# from the belt store
belt skill use inferencesh/web-search

# from github (full url)
belt skill use github.com/anthropics/courses/tree/main/prompt-eng

# from github (shorthand — tries store first, then github.com/user/repo)
belt skill use okaris/my-skill

# pick a specific skill from a multi-skill repo
belt skill use github.com/anthropics/skills --skill frontend-design

# pipe into a file if needed
belt skill use inferencesh/web-search > SKILL.md
```

## installing skills (persistent)

`belt skill add` installs locally. auto-detects which agents you have (`~/.claude/`, `~/.cursor/`, `~/.windsurf/`) and writes to all of them.

```bash
# install for all detected agents
belt skill add namespace/skill-name

# install for a specific agent
belt skill add namespace/skill-name --agent claude-code
belt skill add namespace/skill-name --agent cursor
belt skill add namespace/skill-name --agent windsurf

# install to a custom directory
belt skill add namespace/skill-name --dir ./my-skills

# list installed
belt skill list

# remove
belt skill remove namespace/skill-name
```

## supplementary files

skills can include extra files (references, scripts, etc.):

```bash
belt skill files inferencesh/web-search           # list files
belt skill view inferencesh/web-search refs/api.md  # view a file
```

## creating skills

a skill is a directory with a `SKILL.md` file:

```
my-skill/
├── SKILL.md          # main skill content (required)
└── helpers.md        # optional additional files
```

`SKILL.md` format:

```markdown
---
name: my-skill
description: one-line description of what this skill does
---

## when to use

describe when an agent should use this skill.

## steps

1. first do this
2. then do that
3. finally verify

## examples

show concrete examples of the skill in action.
```

## publishing

```bash
# upload to registry
belt skill upload ./my-skill

# update an existing skill
belt skill upload ./my-skill --update
```

## using skills directly

```bash
# use a skill without installing (one-shot)
belt skill use namespace/skill-name

# view skill content
belt skill view namespace/skill-name
```
