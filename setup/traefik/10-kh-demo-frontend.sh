#!/usr/bin/env bash

# Variables
ENV_FILE=${HOME}/henk/.env
TRAEFIK_DIR=${HOME}/henk/conf/traefik

# Load env
source "${ENV_FILE}"

# Kinky Harbor: Frontend
tee ${TRAEFIK_DIR:?}/kh-demo-frontend.yml <<EOF
http:
  routers:
    KHDemoFrontend:
      entryPoints: ["websecure"]
      rule: Host(\`demo.${DEFAULT_DOMAIN:?}\`)
      middlewares: ["KHFrontendMaintenanceOnBadGateway"]
      service: kh-demo-frontend-${HOSTNAME:?}@docker
      tls:
        certResolver: le-tls
EOF
