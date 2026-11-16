#!/bin/sh
# Runs database migrations and seeds the system roles (idempotent), then
# starts the API. Replaces upstream's separate one-shot "migrator" container.
set -e
cd /app/packages/server
./scripts/migrate.sh
exec node ./dist/index.js
