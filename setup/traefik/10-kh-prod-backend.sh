#!/usr/bin/env bash

# Variables
ENV_FILE=${HOME}/henk/.env
TRAEFIK_DIR=${HOME}/henk/conf/traefik

# Load env
source "${ENV_FILE}"

# Kinky Harbor: Backend
tee ${TRAEFIK_DIR:?}/kh-prod-backend.yml <<EOF
http:
  routers:
    KHProdBackend:
      entryPoints: ["websecure"]
      rule: Host(\`api.${DEFAULT_DOMAIN:?}\`)
      middlewares: ["KHBackendRedirectToDemo"]
      service: kh-demo-backend-${HOSTNAME:?}@docker
      tls:
        certResolver: le-tls
EOF
