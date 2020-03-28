#!/usr/bin/env bash

# Variables
ENV_FILE=${HOME}/henk/.env
TRAEFIK_DIR=${HOME}/henk/conf/traefik

# Load env
source "${ENV_FILE}"

# Kinky Harbor: Frontend
tee ${TRAEFIK_DIR:?}/kh-test-backend.yml <<EOF
http:
  routers:
    KHTestBackend:
      entryPoints: ["websecure"]
      rule: Host(\`test-api.${DEFAULT_DOMAIN:?}\`)
      service: kh-test-backend-${HOSTNAME:?}@docker
      tls:
        certResolver: le-tls
EOF
