#!/usr/bin/env bash

# Variables
ENV_FILE=${HOME}/henk/.env
TRAEFIK_DIR=${HOME}/henk/conf/traefik

# Load env
source "${ENV_FILE}"

# Kinky Harbor: Frontend
tee ${TRAEFIK_DIR:?}/kh-beta-frontend.yml <<EOF
http:
  routers:
    KHBetaFrontend:
      entryPoints: ["websecure"]
      rule: Host(\`beta.${DEFAULT_DOMAIN:?}\`)
      middlewares: ["KHRedirectToDemo"]
      service: kh-demo-frontend-${HOSTNAME:?}@docker
      tls:
        certResolver: le-tls
EOF
