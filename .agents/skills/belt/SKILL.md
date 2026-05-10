---
name: belt
description: "Use the belt CLI — run 250+ AI apps, manage knowledge, search skills, connect MCP servers"
allowed-tools: Bash(belt *)
---

## belt cli

belt is the cloud platform cli for ai agents. single ~4mb binary, no runtime dependencies.

### install

```bash
curl -fsSL cli.inference.sh | sh
belt login
belt me
```

### apps — run 250+ ai models

```bash
belt app search "flux"                    # find apps
belt app get fal/flux-pro                 # view schema
belt app sample fal/flux-pro --save in.json  # generate sample input
belt app run fal/flux-pro --input in.json    # run it
belt app run fal/flux-pro --input '{"prompt": "..."}' --save output.png
```

common apps:
- image: `fal/flux-pro`, `fal/real-esrgan` (upscale)
- video: `google/veo-2`, `seedance/seedance-2-i2v`
- search: `tavily/search`, `exa/search`
- audio: `elevenlabs/tts`

### knowledge — persistent agent memory

```bash
belt know search "query"                  # semantic search
belt know list --type observation         # list by type
belt know get namespace/name              # get details
belt know create ./file.md --type concept # create from file
echo "learned X" | belt know create - --name x --type observation  # from stdin
belt know delete <id>
```

types: `skill`, `concept`, `observation`, `reference`, `preference`

### skills — reusable workflows

```bash
belt skill search "deployment"            # search registry
belt skill store --featured               # browse featured
belt skill install namespace/skill-name   # auto-detects agents, installs for all
belt skill install ns/name --agent claude-code  # install for specific agent
belt skill install ns/name --dir ./skills # install to custom dir
belt skill list                           # list installed
belt skill use namespace/skill-name       # one-shot use without installing
belt skill upload ./my-skill              # publish
```

### connectors — mcp servers

```bash
belt mcp list                             # available connectors
belt mcp search "slack"                   # search
belt mcp connect slack                    # connect
belt mcp tools slack                      # list tools
belt mcp run slack send_message --input '{"channel": "#general", "text": "hello"}'
```

### suggest — unified search

```bash
belt suggest "how to generate images"     # searches apps + skills + knowledge
```

### tips

- use `--json` for structured output when piping
- use `--save filename` to save media outputs directly
- `belt app sample` generates valid input — start there for unfamiliar apps
- `belt update` to get latest version
