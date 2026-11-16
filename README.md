# Playwright MCP on Railway

[![Deploy on Railway](https://railway.com/button.svg)](https://railway.com/new/template/playwright-mcp?utm_medium=integration&utm_source=button&utm_campaign=playwright-mcp)

Railway template for [Playwright MCP](https://github.com/microsoft/playwright-mcp), Microsoft's Model Context Protocol server that gives AI agents a real headless browser. A small Caddy gateway in front of it requires a bearer token on every request, because Playwright MCP has no authentication of its own.

## What it deploys

| Service | Folder | Base image | Networking |
| --- | --- | --- | --- |
| `gateway` | [`gateway/`](gateway) | `caddy:2.11.9-alpine` (pinned by digest) | public domain, port 8080, health check `/healthz` |
| `playwright` | [`playwright/`](playwright) | `mcr.microsoft.com/playwright/mcp:v0.0.85` (pinned by digest) | private network only, port 8931 |

Both services build from this repository (root directories `/gateway` and `/playwright`). Nothing is stored on disk: each MCP session gets an isolated in-memory browser profile, and snapshot or screenshot files go to `/tmp/playwright-mcp` (capped at 100 MB).

## Variables

| Variable | Service | Default | Purpose |
| --- | --- | --- | --- |
| `MCP_API_TOKEN` | gateway | generated 48-character secret | Bearer token required on every request. The gateway refuses to start without one |
| `MCP_UPSTREAM` | gateway | `${{playwright.RAILWAY_PRIVATE_DOMAIN}}:8931` | Where the gateway forwards requests |
| `MCP_URL` | gateway | `https://${{RAILWAY_PUBLIC_DOMAIN}}/mcp` | The endpoint to give your MCP client (read-only convenience) |
| `PORT` | both | `8080` gateway, `8931` playwright | Listening ports |

Optional, on the `playwright` service: `PLAYWRIGHT_MCP_IDLE_TIMEOUT_MS` (default `600000`, closes an idle browser after 10 minutes), `PLAYWRIGHT_MCP_OUTPUT_MAX_BYTES` (default `104857600`).

## Connect a client

Copy `MCP_URL` and `MCP_API_TOKEN` from the gateway service's Variables tab. For Claude Code:

```bash
claude mcp add --transport http playwright https://YOUR-GATEWAY-DOMAIN/mcp \
  --header "Authorization: Bearer YOUR-MCP-API-TOKEN"
```

Any MCP client that supports Streamable HTTP and custom headers works the same way. The legacy SSE transport is at `/sse`.

## Security

The browser can reach the public internet and the project's Railway private network. Treat `MCP_API_TOKEN` like a password and rotate it (change the variable, then redeploy the gateway) if it leaks.

## Updates

Railway notifies everyone who deployed this template when a change is merged to `main`; you choose when to apply it. Each release is listed in [CHANGELOG.md](CHANGELOG.md), breaking changes first.

This is a community-maintained deployment package and is not affiliated with Microsoft or the Playwright project.
