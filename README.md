# belt

the cloud platform cli for ai agents. run ai apps, manage knowledge, search and publish skills, connect to mcp servers — all from your terminal.

**~4mb binary. no runtime, no dependencies. installs in under a second.**

built with go. ships as a single static binary per platform — no node, no python, no containers.

## install

```bash
curl -fsSL https://cli.inference.sh -o /tmp/belt-install.sh && sh /tmp/belt-install.sh
```

package managers:

```bash
brew install inference-sh/tap/belt       # macos / linux
npm install -g @inferencesh/belt         # node.js (downloads native binary)
scoop bucket add belt https://github.com/belt-sh/scoop-belt && scoop install belt  # windows
```

## quick start

```bash
belt login                          # authenticate
belt me                             # check who you are
belt balance                        # check credits

belt suggest "image generation"     # find apps, skills, knowledge
belt app store --category video     # browse by category
belt app get reve/create            # see schema + pricing
belt app sample reve/create --save input.json  # generate sample input
belt app run reve/create --input input.json    # run it
```

## commands

### apps

run ai apps — image generation, video, audio, llms, search, 3d, and more.

```bash
belt app store                          # browse the app store
belt app store --category image         # filter by category
belt app store search "video"           # search
belt app get <namespace/name>           # app details + schema + pricing

belt app sample <namespace/name>        # generate sample input
belt app run <namespace/name> --input input.json
belt app run <namespace/name> --input '{"prompt": "a cat in space"}'

belt app pricing <namespace/name>       # see cost formula before running
belt task cost <task-id>                # see actual cost after running
```

**local files work directly** — file fields (type: `file` in schema) accept local paths. the cli auto-uploads them:

```bash
belt app run bytedance/seedance-2-0 --input '{"image": "./photo.jpg", "prompt": "make it cinematic"}'
```

**multi-function apps:**

```bash
belt app get heygen/avatar-video                # shows all functions
belt app run heygen/avatar-video -f list_resources --input '{}'
belt app sample heygen/avatar-video -f list_resources
```

### app development

```bash
belt app init my-app                    # scaffold new app
belt app test --input input.json        # test locally
belt app deploy                         # deploy to inference.sh
belt app deploy --dry-run               # validate without deploying
belt app list                           # list your deployed apps
belt app pull [id]                      # pull app source
```

### knowledge

save and recall knowledge — discoveries, insights, references, preferences.

```bash
belt knowledge list                     # list entries
belt knowledge list --type skill        # filter by type
belt knowledge search "deployment"      # semantic search
belt knowledge get namespace/name       # get details
belt knowledge upload ./notes.md        # upload from file
```

### skills

search, install, and publish skills from the registry.

```bash
belt skill store                        # browse store
belt skill store search "web"           # search registry
belt skill use namespace/skill-name     # use on-demand (nothing written to disk)
belt skill add namespace/skill-name     # install persistently
belt skill list                         # list installed
belt skill upload ./my-skill            # publish
```

### connectors (mcp)

connect to mcp servers and run tools.

```bash
belt mcp list                           # browse available connectors
belt mcp search "slack"                 # search
belt mcp connect slack                  # connect
belt mcp run slack send_message --input '{"channel": "#general", "text": "hello"}'
```

### secrets

```bash
belt secrets list                       # list secrets
belt secrets set MY_KEY sk-12345        # set a secret
belt secrets get MY_KEY                 # get a secret
belt secrets delete MY_KEY              # delete
```

### machine-readable output

all list commands support `--json`:

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

### other

```bash
belt version                            # print version
belt update                             # update to latest
belt completion bash                    # shell completions
```

## agent integration

belt works with ai coding agents. install the [plugin](https://github.com/belt-sh/skills) for deep integration:

```bash
belt plugin init claude     # claude code
belt plugin init codex      # openai codex
belt plugin init cursor     # cursor
belt plugin init gemini     # gemini cli
belt plugin init pi         # pi
belt plugin init opencode   # opencode
belt plugin init windsurf   # windsurf
```

this adds automatic skill/knowledge/app suggestions on every prompt, background knowledge capture, and slash commands (`/belt`, `/skill`, `/skillify`, `/knowledge`, `/apps`, `/suggest`, `/agentify`, `/appify`, `/flowify`).

### disable hooks for a project

add `.beltsh/config.json`:

```json
{"hooks_disabled": true}
```

or set `BELT_NO_HOOKS=1`.

granular: `suggest_disabled` (no prompt matching) · `knowledge_disabled` (no session extraction).

## environment variables

| variable | description |
|----------|-------------|
| `INFSH_API_KEY` | api key (overrides login config) |
| `BELT_NO_UPDATE_CHECK` | disable automatic update checks |
| `BELT_NO_HOOKS` | disable all plugin hooks |

## why belt

- **~4mb** single binary — no bundled runtime
- **apps** — image gen, video, audio, llms, search, 3d in one cli
- **knowledge system** — persistent memory across sessions and agents
- **skill registry** — discover, install, and publish reusable agent skills
- **mcp connectors** — connect any mcp server through the platform
- **agent-native** — typed json output, non-interactive mode, plugin system
- **local file upload** — just use file paths in your input, cli handles the rest

## links

- [inference.sh](https://inference.sh) — platform
- [belt.sh](https://belt.sh) — landing page
- [docs](https://inference.sh/docs) — documentation
- [trust](https://inference.sh/trust) — security & data handling
- [belt-sh/skills](https://github.com/belt-sh/skills) — agent plugin
- [issues](https://github.com/belt-sh/cli/issues) — bug reports & feature requests

## license

mit
