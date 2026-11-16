#!/bin/sh
# Derives the public URLs from Railway's domain, then hands over to upstream's
# inject-app-env.sh, which writes them into index.html and starts Caddy.
set -e
if [ -n "$RAILWAY_PUBLIC_DOMAIN" ]; then
  default_url="https://$RAILWAY_PUBLIC_DOMAIN"
else
  default_url="http://localhost:${PORT:-3000}"
fi
export VITE_WEBAPP_URL="${VITE_WEBAPP_URL:-$default_url}"
# The browser calls the API on the same origin; Caddy proxies /api to it.
export VITE_API_URL="${VITE_API_URL:-$VITE_WEBAPP_URL}"
export VITE_IS_SELF_HOSTED="${VITE_IS_SELF_HOSTED:-true}"
export LOGCHIMP_API_UPSTREAM="${LOGCHIMP_API_UPSTREAM:-api:8000}"
exec /app/inject-app-env.sh "$@"
