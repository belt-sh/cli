# agents working with belt

this file provides context for any ai agent (claude, cursor, copilot, etc.) working in a project where belt is available.

## what belt is

belt is a cli that gives agents access to:

1. **250+ ai apps** — image generation (flux, sdxl), video (veo, seedance), audio (tts, music), llms (claude, gpt, gemini), search (tavily, exa), 3d, and more
2. **knowledge system** — persistent memory that survives across sessions. save observations, concepts, skills, references
3. **skill registry** — reusable agent workflows. search, install, publish
4. **mcp connectors** — connect to any mcp-compatible service through the platform

## when to use belt

- **generating media**: `belt app search "image"` → `belt app run fal/flux-pro --input '{"prompt": "..."}'`
- **remembering something**: `belt know create - --name finding --type observation <<< "learned X"`
- **looking for a workflow**: `belt skill search "deploy"` or `belt suggest "how to do X"`
- **connecting to services**: `belt mcp connect slack` → `belt mcp run slack send_message`
- **web search / research**: `belt app run tavily/search --input '{"query": "..."}'`

## output format

- tty mode: human-readable, colored output
- piped/`--json`: structured json, safe for parsing
- always use `--json` when you need to process output programmatically

## conventions

- app inputs are always json (`--input` flag or file path)
- knowledge types: `skill`, `concept`, `observation`, `reference`, `preference`
- skill names follow `namespace/name` format
- apps follow `owner/app-name` or `owner/app-name@version` format

## error handling

belt exits non-zero on failure with a descriptive error message. common issues:
- not authenticated → `belt login`
- app not found → check spelling, try `belt app search`
- invalid input → use `belt app sample` to generate valid input schema
