# Changelog

## 2026-11-16: Playwright MCP v0.0.85, built from this repository

- The template now builds both services from this repository instead of running images directly, so deployers get update notices from Railway.
- Playwright MCP v0.0.82 → v0.0.85 (`mcr.microsoft.com/playwright/mcp:v0.0.85@sha256:cc70a6922ff856f3aba0fe97d0d94220dc9a7f367f6d332facc6d81d9a91e60e`).
- Caddy 2.11.4 → 2.11.9 (`caddy:2.11.9-alpine@sha256:003a97808e781aa9f7e75cc2f43d34d461099031faf5e20faefb9f61126836f0`).
- The Caddyfile is baked into the gateway image; the `CADDYFILE` variable is no longer used.
- The gateway refuses to start when `MCP_API_TOKEN` is empty or shorter than 16 characters.
- Snapshot and screenshot files go to `/tmp/playwright-mcp`, capped at 100 MB, instead of growing without limit in the home directory.
- An idle browser closes after 10 minutes (was 1 hour) and relaunches on the next tool call.
- Both services restart always, instead of giving up after 10 failures.
