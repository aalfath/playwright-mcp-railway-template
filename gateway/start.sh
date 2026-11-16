#!/bin/sh
# Refuse to start without a real token: an empty MCP_API_TOKEN would make the
# "Bearer " header match and open the browser to anyone.
set -e
if [ "${#MCP_API_TOKEN}" -lt 16 ]; then
  echo "MCP_API_TOKEN is missing or shorter than 16 characters; refusing to start." >&2
  exit 1
fi
if [ -z "$MCP_UPSTREAM" ]; then
  echo "MCP_UPSTREAM is not set (expected the Playwright service's private host:port)." >&2
  exit 1
fi
exec caddy run --config /etc/caddy/Caddyfile --adapter caddyfile
