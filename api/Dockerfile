# LogChimp API (Express + Knex), official image pinned by version and digest.
FROM ghcr.io/logchimp/logchimp/api:0.9.4@sha256:de6e356644d0b6692a7e9e038eb90da5c09ab5ae86e9836a5ec658e3611f3e8e

# Fixed settings for Railway. LOGCHIMP_SERVER_PORT wins over Railway's PORT,
# so the web service always finds the API on 8000. "::" listens on IPv4 and
# IPv6, which Railway's private network needs.
ENV NODE_ENV=production \
    LOGCHIMP_IS_SELF_HOSTED=true \
    LOGCHIMP_API_HOST=:: \
    LOGCHIMP_SERVER_PORT=8000 \
    LOGCHIMP_DB_SSL=false

COPY start.sh /usr/local/bin/logchimp-start
RUN chmod +x /usr/local/bin/logchimp-start

EXPOSE 8000
CMD ["/usr/local/bin/logchimp-start"]
