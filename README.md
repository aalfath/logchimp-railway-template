[![Deploy on Railway](https://railway.com/button.svg)](https://railway.com/new/template/logchimp-1?utm_medium=integration&utm_source=button&utm_campaign=logchimp)

# LogChimp on Railway

Railway template for [LogChimp](https://github.com/logchimp/logchimp), an open-source tool for collecting customer feedback, voting on feature requests and publishing a roadmap.

- **LogChimp version:** 0.9.4 (`ghcr.io/logchimp/logchimp/api:0.9.4` and `ghcr.io/logchimp/logchimp/theme:0.9.4`, both pinned by digest in the Dockerfiles)
- **Licence of LogChimp:** AGPL-3.0, with an Enterprise Edition directory under its own licence (see upstream `LICENSE`)

## What the template deploys

| Service | Built from | Public | Storage |
|---|---|---|---|
| **LogChimp** | [`web/`](web) – the official theme image (Vue app served by Caddy). Its Caddy also forwards `/api/*` to the API over Railway's private network | yes, one Railway domain | none |
| **LogChimp API** | [`api/`](api) – the official API image (Node.js). Database migrations and system roles run on every start, so there is no separate migrator service | no (private network only) | none |
| **Postgres** | Railway's PostgreSQL | no | volume |

Open the LogChimp domain after the deploy finishes. The first visit leads to `/setup`, where you create the owner account and name the site. Setup can only be done once.

## Variables

All variables are filled in by Railway; the template asks you for nothing.

| Service | Variable | Value |
|---|---|---|
| LogChimp API | `LOGCHIMP_DB_URL` | `${{Postgres.DATABASE_URL}}` |
| LogChimp API | `LOGCHIMP_SECRET_KEY` | generated secret (64 characters) |
| LogChimp API | `LOGCHIMP_MACHINE_SIGNATURE` | generated secret (32 characters) |
| LogChimp API | `LOGCHIMP_WEB_URL` | `https://${{LogChimp.RAILWAY_PUBLIC_DOMAIN}}` |
| LogChimp | `LOGCHIMP_API_UPSTREAM` | `${{"LogChimp API".RAILWAY_PRIVATE_DOMAIN}}:8000` |

Fixed settings (`NODE_ENV=production`, `LOGCHIMP_IS_SELF_HOSTED=true`, the API listening on `[::]:8000`) are baked into `api/Dockerfile`. The web service derives its public URL from `RAILWAY_PUBLIC_DOMAIN` in `web/start.sh`.

### Optional settings

Add these to the **LogChimp API** service when you need them:

- **Email** (verification and password-reset emails): `LOGCHIMP_MAIL_HOST`, `LOGCHIMP_MAIL_PORT`, `LOGCHIMP_MAIL_USER`, `LOGCHIMP_MAIL_PASSWORD`. Without SMTP, sign-up and setup still work; the emails just aren't sent.
- **Cache:** add a Redis or Valkey service and set `LOGCHIMP_VALKEY_URL` to its URL (for example `${{Redis.REDIS_URL}}`). LogChimp only uses it to cache site settings and boards.
- **Enterprise licence:** `LOGCHIMP_LICENSE_KEY` and `LOGCHIMP_SIGNATURE_TOKEN` from [pilot.logchimp.app](https://pilot.logchimp.app).
- **Blocked sign-up domains:** `LOGCHIMP_BLACKLISTED_DOMAINS` (comma separated).

## Updates

This template builds from this repository's `main` branch. When a new LogChimp release is tested, the image pins in `api/Dockerfile` and `web/Dockerfile` are bumped and the change is merged to `main`. Railway then shows an "update available" notice on your project, and you choose when to apply it. Read [CHANGELOG.md](CHANGELOG.md) first. Database migrations run automatically when the API starts.

## Run it locally

```sh
docker compose up --build
```

Then open http://localhost:42251. The Compose file is only for local testing (it uses a fixed test password).
