# belt

the cloud platform cli for ai agents. run 250+ ai apps, manage knowledge, search and publish skills, connect to mcp servers — all from your terminal.

**~4mb binary. no runtime, no dependencies. installs in under a second.**

built with go. ships as a single static binary per platform — no node, no python, no containers. just `curl | sh` and you're running.

## install

```bash
curl -fsSL cli.inference.sh | sh
```

package managers:

```bash
brew install inference-sh/tap/belt       # macos / linux
npx @inferencesh/belt                    # node.js (downloads native binary)
scoop bucket add inference https://github.com/inference-sh/scoop-bucket && scoop install belt  # windows
```

pin a version:

```bash
VERSION=v1.11.1 curl -fsSL cli.inference.sh | sh
```

## quick start

```bash
belt login                    # authenticate
belt me                       # check who you are

belt app search "flux"        # find ai apps
belt app run fal/flux-pro     # run one

belt know search "react"      # search your knowledge
belt skill search "deploy"    # find skills
```

## commands

### apps

run 250+ ai apps — image generation, video, audio, llms, search, 3d, and more.

```bash
belt app list                           # browse available apps
belt app list --featured                # featured apps
belt app list --category image          # filter by category
belt app search "video generation"      # search

belt app run user/app --input input.json
belt app run user/app --input '{"prompt": "a cat in space"}'
belt app sample user/app                # generate sample input
belt app sample user/app --save in.json # save sample to file

belt app get user/app                   # app details + schema
```

### app development

```bash
belt app init my-app                    # scaffold new app
belt app test --input input.json        # test locally
belt app deploy                         # deploy to inference.sh
belt app deploy --dry-run               # validate without deploying
belt app my                             # list your deployed apps
belt app pull [id]                      # pull app source
```

### knowledge

save and recall knowledge — discoveries, insights, references, preferences.

```bash
belt know list                          # list entries
belt know list --type skill             # filter by type
belt know search "deployment"           # semantic search

belt know get namespace/name            # get details
belt know create ./my-skill/            # create from directory
belt know create ./notes.md             # create from file
belt know create - --name x --type observation  # from stdin
belt know delete <id>                   # delete entry
```

### skills

search, install, and publish skills from the registry.

```bash
belt skill search "image generation"    # search registry
belt skill store                        # browse store
belt skill store --featured             # featured skills

belt skill add namespace/skill-name     # install a skill
belt skill add ns/skill --agent claude  # install for specific agent
belt skill list                         # list installed

belt skill upload ./my-skill            # publish to registry
```

### connectors (mcp)

connect to mcp servers and run tools.

```bash
belt mcp list                           # list available connectors
belt mcp search "slack"                 # search connectors
belt mcp connect slack                  # connect to one
belt mcp tools slack                    # list available tools
belt mcp run slack send_message --input '{"channel": "#general", "text": "hello"}'
belt mcp disconnect slack               # disconnect
```

### secrets

```bash
belt secrets list                       # list secrets
belt secrets set MY_KEY sk-12345        # set a secret
belt secrets get MY_KEY                 # get a secret
belt secrets delete MY_KEY              # delete
```

### other

```bash
belt version                            # print version
belt update                             # update to latest
belt completion bash                    # shell completions
belt help                               # help
```

## agent integration

belt is designed to work with ai coding agents. install the [claude code plugin](https://github.com/belt-sh/skills) for deep integration:

- automatic skill/knowledge/app suggestions on every prompt
- background knowledge capture from sessions
- 5 slash commands: `/belt`, `/skill`, `/knowledge`, `/apps`, `/suggest`

```bash
# in claude code
/install-plugin belt-sh/skills
```

or use belt directly from any agent via shell:

```bash
belt suggest "what tool should i use for image upscaling"
belt app run fal/real-esrgan --input '{"image_url": "..."}'
belt know search "api patterns"
```

## environment variables

| variable | description |
|----------|-------------|
| `INFSH_API_KEY` | api key (overrides login config) |
| `BELT_NO_UPDATE_CHECK` | disable automatic update checks |

## shell completions

```bash
belt completion bash > /etc/bash_completion.d/belt       # bash
belt completion zsh > "${fpath[1]}/_belt"                 # zsh
belt completion fish > ~/.config/fish/completions/belt.fish  # fish
```

## why belt

- **~4mb** single binary (go, compiled + compressed) — no bundled runtime
- **250+ apps** — image gen, video, audio, llms, search, 3d in one cli
- **knowledge system** — persistent memory across sessions and agents
- **skill registry** — discover, install, and publish reusable agent skills
- **mcp connectors** — connect any mcp server through the platform
- **agent-native** — structured json output, non-interactive mode, plugin system

## links

- [inference.sh](https://inference.sh) — platform
- [app.inference.sh/docs](https://app.inference.sh/docs) — documentation
- [belt-sh/skills](https://github.com/belt-sh/skills) — claude code plugin
- [issues](https://github.com/belt-sh/cli/issues) — bug reports & feature requests

## license

mit
