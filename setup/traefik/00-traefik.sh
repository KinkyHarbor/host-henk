#!/usr/bin/env bash

# Variables
ENV_FILE=${HOME}/henk/.env
TRAEFIK_DIR=${HOME}/henk/conf/traefik

# Load env
source "${ENV_FILE}"

# Traefik: Common
tee ${TRAEFIK_DIR:?}/traefik-common.yml <<EOF
http:
  middlewares:
    SecureHttps:
      headers:
        stsSeconds: 15552000
        sslredirect: true

    HttpsRedirect:
      redirectScheme:
        scheme: https
        permanent: true

  routers:
    HttpsRedirect:
      entryPoints: ["web"]
      rule: HostRegexp(\`{any:.*}\`)
      service: ping@internal
      middlewares: ["HttpsRedirect"]
EOF

# Traefik: Dashboard
tee ${TRAEFIK_DIR:?}/traefik-dashboard.yml <<EOF
http:
  middlewares:
    TraefikDashboardAuth:
      basicAuth:
        users:
         - "${TRAEFIK_API_AUTH:?}"

  routers:
    API:
      entryPoints: ["websecure"]
      rule: Host(\`traefik-${HOSTNAME:?}.${DEFAULT_DOMAIN:?}\`)
      service: api@internal
      middlewares:
        - TraefikDashboardAuth
        - SecureHttps
      tls:
        certResolver: le-tls

    APIBE:
      entryPoints: ["websecure"]
      rule: Host(\`traefik-${HOSTNAME:?}.${DOMAIN_BE:?}\`)
      service: api@internal
      middlewares:
        - TraefikDashboardAuth
        - SecureHttps
      tls:
        certResolver: le-tls

    APINL:
      entryPoints: ["websecure"]
      rule: Host(\`traefik-${HOSTNAME:?}.${DOMAIN_NL:?}\`)
      service: api@internal
      middlewares:
        - TraefikDashboardAuth
        - SecureHttps
      tls:
        certResolver: le-tls
EOF

# Traefik: Ping
tee ${TRAEFIK_DIR:?}/traefik-ping.yml <<EOF
http:
  routers:
    Ping:
      entryPoints: ["websecure"]
      rule: Host(\`ping-${HOSTNAME:?}.${DEFAULT_DOMAIN:?}\`)
      service: ping@internal
      tls:
        certResolver: le-tls

    PingBE:
      entryPoints: ["websecure"]
      rule: Host(\`ping-${HOSTNAME:?}.${DOMAIN_BE:?}\`)
      service: ping@internal
      tls:
        certResolver: le-tls

    PingNL:
      entryPoints: ["websecure"]
      rule: Host(\`ping-${HOSTNAME:?}.${DOMAIN_NL:?}\`)
      service: ping@internal
      tls:
        certResolver: le-tls
EOF
