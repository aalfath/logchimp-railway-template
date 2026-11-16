# LogChimp web app (Vue theme served by Caddy), official image pinned by version and digest.
FROM ghcr.io/logchimp/logchimp/theme:0.9.4@sha256:2436bec664f4293474a5a491405af2bb56e15984bddcd5eefb19f83f044cf8cf

# Same as upstream's Caddyfile, plus a reverse proxy from /api to the API
# service over Railway's private network, so only this service needs a domain.
COPY Caddyfile /app/Caddyfile
COPY start.sh /app/railway-start.sh
RUN chmod +x /app/railway-start.sh && caddy fmt /app/Caddyfile --overwrite

ENTRYPOINT ["/app/railway-start.sh"]
CMD ["caddy", "run", "--config", "/app/Caddyfile", "--adapter", "caddyfile"]
