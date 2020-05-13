#!/usr/bin/env bash

# Variables
ENV_FILE=${HOME}/henk/.env
TRAEFIK_DIR=${HOME}/henk/conf/traefik

# Load env
source "${ENV_FILE}"

# Kinky Harbor: Backend
tee ${TRAEFIK_DIR:?}/kh-demo-backend.yml <<EOF
http:
  routers:
    KHDemoBackend:
      entryPoints: ["websecure"]
      rule: Host(\`demo-api.${DEFAULT_DOMAIN:?}\`)
      service: kh-demo-backend-${HOSTNAME:?}@docker
      tls:
        certResolver: le-tls
EOF
