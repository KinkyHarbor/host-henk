#!/usr/bin/env bash

# Variables
ENV_FILE=${HOME}/henk/.env
TRAEFIK_DIR=${HOME}/henk/conf/traefik

# Load env
source "${ENV_FILE}"

# Kinky Harbor: Frontend
tee ${TRAEFIK_DIR:?}/kh-frontend.yml <<EOF
http:
  routers:
    KHFrontend:
      entryPoints: ["websecure"]
      rule: Host(\`${DEFAULT_DOMAIN:?}\`)
      service: kh-frontend-${HOSTNAME:?}@docker
      tls:
        certResolver: le-tls
EOF
