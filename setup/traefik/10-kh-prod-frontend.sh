#!/usr/bin/env bash

# Variables
ENV_FILE=${HOME}/henk/.env
TRAEFIK_DIR=${HOME}/henk/conf/traefik

# Load env
source "${ENV_FILE}"

# Kinky Harbor: Frontend
tee ${TRAEFIK_DIR:?}/kh-prod-frontend.yml <<EOF
http:
  routers:
    KHProdFrontend:
      entryPoints: ["websecure"]
      rule: Host(\`${DEFAULT_DOMAIN:?}\`)
      middlewares: ["KHFrontendRedirectToDemo"]
      service: kh-demo-frontend-${HOSTNAME:?}@docker
      tls:
        certResolver: le-tls

    KHProdFrontendBE:
      entryPoints: ["websecure"]
      rule: Host(\`${DOMAIN_BE:?}\`)
      middlewares: ["KHFrontendRedirectToDemo"]
      service: kh-demo-frontend-${HOSTNAME:?}@docker
      tls:
        certResolver: le-tls

    KHProdFrontendNL:
      entryPoints: ["websecure"]
      rule: Host(\`${DOMAIN_NL:?}\`)
      middlewares: ["KHFrontendRedirectToDemo"]
      service: kh-demo-frontend-${HOSTNAME:?}@docker
      tls:
        certResolver: le-tls
EOF
