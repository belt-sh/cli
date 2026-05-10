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

## installing skills

belt auto-detects which agents you have installed (`~/.claude/`, `~/.cursor/`, `~/.windsurf/`) and installs skills for all of them.

```bash
# install for all detected agents
belt skill install namespace/skill-name

# install for a specific agent
belt skill install namespace/skill-name --agent claude-code
belt skill install namespace/skill-name --agent cursor
belt skill install namespace/skill-name --agent windsurf

# install to a custom directory
belt skill install namespace/skill-name --dir ./my-skills

# list installed
belt skill list

# remove
belt skill remove namespace/skill-name
```

supported agents: `claude-code`, `cursor`, `windsurf`

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
