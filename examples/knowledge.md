# knowledge management

belt's knowledge system gives agents persistent memory across sessions. save discoveries, patterns, references — anything worth remembering.

## types

| type | use for |
|------|---------|
| `observation` | things you noticed or learned |
| `concept` | mental models, explanations |
| `skill` | reusable workflows with steps |
| `reference` | links to external resources |
| `preference` | user preferences, style choices |

## saving knowledge

```bash
# from stdin (quick observations)
echo "react server components can't use useState" | belt know create - --name rsc-no-state --type observation

# from a file
belt know create ./api-patterns.md --type concept

# from a directory (skills with multiple files)
belt know create ./my-workflow/ --type skill

# with explicit metadata
belt know create ./notes.md --name deployment-checklist --type reference
```

## searching

```bash
# semantic search
belt know search "error handling patterns"
belt know search "react hooks"

# list by type
belt know list --type skill
belt know list --type observation

# get full details
belt know get myteam/deployment-checklist
```

## agent usage

agents can use knowledge to build context:

```bash
# before starting work, check what's known
belt know search "auth middleware" --json

# after discovering something, save it
belt know create - --name finding --type observation <<EOF
the auth middleware caches tokens for 5 minutes.
invalidation requires a redis pub/sub message.
EOF
```

## knowledge in the claude code plugin

with the [belt-sh/skills](https://github.com/belt-sh/skills) plugin installed, knowledge is automatically:

- searched on every prompt (via the suggest hook)
- captured from sessions (via the stop hook with haiku evaluation)
- deduplicated before saving (via the knowledge-curator agent)
