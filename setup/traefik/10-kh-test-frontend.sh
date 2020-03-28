#!/usr/bin/env bash

# Variables
ENV_FILE=${HOME}/henk/.env
TRAEFIK_DIR=${HOME}/henk/conf/traefik

# Load env
source "${ENV_FILE}"

# Kinky Harbor: Frontend
tee ${TRAEFIK_DIR:?}/kh-test-frontend.yml <<EOF
http:
  routers:
    KHTestFrontend:
      entryPoints: ["websecure"]
      rule: Host(\`test.${DEFAULT_DOMAIN:?}\`)
      middlewares: ["KHFrontendMaintenanceOnBadGateway"]
      service: kh-test-frontend-${HOSTNAME:?}@docker
      tls:
        certResolver: le-tls
EOF
