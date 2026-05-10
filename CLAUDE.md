# belt cli

belt is the cli for inference.sh — a cloud platform for ai agents. it provides access to 250+ ai apps, a knowledge system, skill registry, and mcp connectors.

## using belt in this project

belt is available as a shell command. use it when:

- you need to run an ai model (image gen, video, audio, llms, search) → `belt app search` + `belt app run`
- you discover something worth remembering → `belt know create`
- you need a reusable skill or workflow → `belt skill search`
- you want to connect to an external service → `belt mcp connect`

## common patterns

```bash
# find and run an app
belt app search "flux"
belt app get fal/flux-pro           # check schema
belt app sample fal/flux-pro --save input.json
belt app run fal/flux-pro --input input.json

# save knowledge
echo "learned that X" | belt know create - --name finding --type observation
belt know create ./discovery.md --type concept

# search for solutions
belt suggest "how to upscale images"
belt skill search "deployment"
belt know search "api patterns"
```

## output

belt outputs structured json when piped or when `--json` is passed. in a tty it renders human-friendly output. agents should use `--json` for reliable parsing.

## key commands

| command | purpose |
|---------|---------|
| `belt app run` | run an ai app |
| `belt app search` | find apps by keyword |
| `belt know search` | search knowledge base |
| `belt know create` | save knowledge |
| `belt skill search` | find skills |
| `belt suggest` | unified search across apps, skills, knowledge |
| `belt mcp run` | execute an mcp tool |
