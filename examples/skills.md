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

```bash
# install for claude code
belt skill add namespace/skill-name
belt skill add namespace/skill-name --agent claude

# install for cursor
belt skill add namespace/skill-name --agent cursor

# list installed
belt skill list
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
