#!/bin/sh
# Start Playwright MCP for use behind the gateway on Railway's private network.
# --host ::                 listen on IPv6 + IPv4 (Railway private networking is IPv6)
# --allowed-hosts '*'       the gateway rewrites Host to the private domain
# --isolated                in-memory browser profile per session, nothing written to disk
# --idle-timeout            close an idle browser after 10 minutes (relaunched on the next call)
# --output-dir / max-size   keep snapshot and screenshot files in /tmp and cap them at 100 MB
set -e
OUTPUT_DIR="${PLAYWRIGHT_MCP_OUTPUT_DIR:-/tmp/playwright-mcp}"
mkdir -p "$OUTPUT_DIR"
exec node /app/cli.js \
  --headless \
  --browser chromium \
  --no-sandbox \
  --isolated \
  --host :: \
  --port "${PORT:-8931}" \
  --allowed-hosts '*' \
  --idle-timeout "${PLAYWRIGHT_MCP_IDLE_TIMEOUT_MS:-600000}" \
  --output-dir "$OUTPUT_DIR" \
  --output-max-size "${PLAYWRIGHT_MCP_OUTPUT_MAX_BYTES:-104857600}" \
  "$@"
