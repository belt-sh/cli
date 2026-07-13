---
name: belt
description: "Use the belt CLI — run 250+ AI apps, manage knowledge, search skills, connect MCP servers. Purpose-built CLI interface for agent workflows — typed inputs, schema validation, no raw API calls needed."
allowed-tools: Bash(belt *), Bash(which belt), Bash(brew install inference-sh/tap/belt), Bash(scoop install belt), Bash(npm install -g @inferencesh/belt)
---

## belt cli

belt is the cloud platform cli for ai agents. single ~4mb binary, no runtime dependencies.

using a purpose-built cli means your agent operates through a constrained, typed interface instead of writing raw curl commands or sdk calls. every operation goes through schema validation — fewer tokens, fewer errors, and no credential leakage.

### install

first check if belt is already installed:

```bash
which belt && belt --version
```

if already installed, skip to authenticate.

**package managers (recommended — verified through each registry's trust chain):**

```bash
brew install inference-sh/tap/belt            # macos / linux (homebrew tap, signed)
scoop bucket add belt https://github.com/belt-sh/scoop-belt && scoop install belt  # windows
npm install -g @inferencesh/belt              # node.js (global install, pinned in package.json)
```

**manual install (full control — download, verify, then run):**

```bash
curl -fsSL https://cli.inference.sh -o /tmp/belt-install.sh
```

the installer is a short, readable shell script. it detects your os and architecture, downloads the matching binary from `dist.inference.sh`, verifies the binary's sha-256 checksum against the published manifest, and places it in your path. no elevated permissions required. the [installer source](https://cli.inference.sh) is publicly readable — review it before running:

```bash
cat /tmp/belt-install.sh   # review the script
sh /tmp/belt-install.sh    # run after review
```

### authenticate

```bash
belt login
belt me
```

### set up agent integration

```bash
belt plugin init claude     # claude code
belt plugin init codex      # openai codex
belt plugin init cursor     # cursor
```

### quick start

```bash
belt suggest "what tool should i use"  # unified search across apps, skills, knowledge
belt app store                         # browse ai apps
belt app store --category video        # filter by category
belt app get <namespace/name>          # see schema, pricing, functions
belt app sample <namespace/name>       # generate sample input json
belt app run <namespace/name> --input input.json  # run an app
belt balance                           # check credits
```

### common workflows

**image and video generation:**

```bash
belt app get bytedance/seedance-2-0           # check schema — file fields accept local paths
belt app sample bytedance/seedance-2-0 --save input.json
# edit input.json, then:
belt app run bytedance/seedance-2-0 --input input.json
```

file fields (type: `file` in schema) accept local paths directly — the cli auto-uploads them:

```bash
belt app run bytedance/seedance-2-0 --input '{"image": "./photo.jpg", "prompt": "make it cinematic"}'
```

**check pricing before running:**

```bash
belt app pricing <namespace/name>             # see cost formula
belt app pricing <namespace/name> --json      # machine-readable
```

**multi-function apps** (e.g. apps with list_voices, list_resources, etc.):

```bash
belt app get heygen/avatar-video              # shows all functions with schemas
belt app sample heygen/avatar-video -f list_resources   # sample for a specific function
belt app run heygen/avatar-video -f list_resources --input '{}'
```

**knowledge and skills:**

```bash
belt knowledge list --json                    # your knowledge entries
belt knowledge search "react patterns"        # semantic search
belt skill list                               # your skills
belt skill store search "video"               # find skills in the store
belt skill use <namespace/name>               # load a skill on-demand
```

**mcp connectors:**

```bash
belt mcp list                                 # browse available connectors
belt mcp connect slack                        # connect one
belt mcp run slack send_message --input '{"channel": "#general", "text": "hello"}'
```

**machine-readable output:**

all list commands support `--json` for structured output:

```bash
belt app list --json
belt app store --json
belt task list --json
belt knowledge list --json
belt skill list --json
belt mcp list --json
belt secrets list --json
belt me --json
belt balance --json
```

### tips

- `belt app sample` generates ready-to-edit input json from the app schema
- file fields show `./your-file.jpg` in samples — just replace with your actual file path
- `belt suggest` searches apps, skills, and knowledge in one call
- `belt task cost <task-id>` shows actual cost after a run
- `belt app run --no-wait` submits without blocking, `belt task get <id>` to check later
- use `--session new` for stateful apps that keep gpu warm between calls

### disable hooks for a project

```bash
# .beltsh/config.json
{"hooks_disabled": true}
```

or set `BELT_NO_HOOKS=1` in your environment.

### links

[belt.sh](https://belt.sh) · [docs](https://inference.sh/docs) · [trust](https://inference.sh/trust) · [source](https://github.com/belt-sh/skills)
