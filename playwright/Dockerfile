# Playwright MCP (Microsoft), headless Chromium, private service.
# Pinned by version and multi-arch index digest. Bump both together.
FROM mcr.microsoft.com/playwright/mcp:v0.0.86@sha256:2dfc17e08e8db54678ec965ce9ffb4100be0aa68135774d761bac9035ceb6668

COPY --chmod=0755 start.sh /usr/local/bin/start-playwright-mcp

ENV PORT=8931
ENTRYPOINT ["/usr/bin/tini", "-s", "--", "/usr/local/bin/start-playwright-mcp"]
