# connectors (mcp)

belt connects to mcp servers through the platform — no local server setup needed. connect once, use tools from any session.

## available connectors

```bash
# list all available
belt mcp list

# search
belt mcp search "slack"
belt mcp search "github"
belt mcp search "database"
```

## connecting

```bash
# connect to a service (may require auth)
belt mcp connect slack
belt mcp connect github
belt mcp connect postgres --config '{"connection_string": "..."}'

# check status
belt mcp get slack

# disconnect
belt mcp disconnect slack
```

## using tools

```bash
# list tools on a connector
belt mcp tools slack
belt mcp tools github

# run a tool
belt mcp run slack send_message --input '{"channel": "#general", "text": "deployed v1.2.3"}'
belt mcp run github create_issue --input '{"repo": "org/repo", "title": "bug: ...", "body": "..."}'

# json output for piping
belt mcp run tavily search --input '{"query": "..."}' --json | jq '.results'
```

## in agent workflows

connectors are useful for agents that need to interact with external services:

```bash
# notify team about deployment
belt mcp run slack send_message --input '{"channel": "#deploys", "text": "v1.2.3 deployed to production"}'

# create a ticket for a found issue
belt mcp run linear create_issue --input '{"title": "fix: race condition in auth", "priority": 2}'

# fetch context from external systems
belt mcp run notion search --input '{"query": "onboarding docs"}' --json
```
