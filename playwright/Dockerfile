# Playwright MCP (Microsoft), headless Chromium, private service.
# Pinned by version and multi-arch index digest. Bump both together.
FROM mcr.microsoft.com/playwright/mcp:v0.0.85@sha256:cc70a6922ff856f3aba0fe97d0d94220dc9a7f367f6d332facc6d81d9a91e60e

COPY --chmod=0755 start.sh /usr/local/bin/start-playwright-mcp

ENV PORT=8931
ENTRYPOINT ["/usr/bin/tini", "-s", "--", "/usr/local/bin/start-playwright-mcp"]
