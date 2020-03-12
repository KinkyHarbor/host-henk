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
      middlewares: ["KHFrontendRedirectToLangNL"]
      service: kh-demo-frontend-${HOSTNAME:?}@docker
      tls:
        certResolver: le-tls

    KHProdFrontendDE:
      entryPoints: ["websecure"]
      rule: Host(\`${DOMAIN_DE:?}\`)
      middlewares: ["KHFrontendRedirectToLangEN"]
      service: kh-demo-frontend-${HOSTNAME:?}@docker
      tls:
        certResolver: le-tls

    KHProdFrontendEU:
      entryPoints: ["websecure"]
      rule: Host(\`${DOMAIN_EU:?}\`)
      middlewares: ["KHFrontendRedirectToLangEN"]
      service: kh-demo-frontend-${HOSTNAME:?}@docker
      tls:
        certResolver: le-tls

    KHProdFrontendFR:
      entryPoints: ["websecure"]
      rule: Host(\`${DOMAIN_FR:?}\`)
      middlewares: ["KHFrontendRedirectToLangEN"]
      service: kh-demo-frontend-${HOSTNAME:?}@docker
      tls:
        certResolver: le-tls

    KHProdFrontendNL:
      entryPoints: ["websecure"]
      rule: Host(\`${DOMAIN_NL:?}\`)
      middlewares: ["KHFrontendRedirectToLangNL"]
      service: kh-demo-frontend-${HOSTNAME:?}@docker
      tls:
        certResolver: le-tls

    KHProdFrontendORG:
      entryPoints: ["websecure"]
      rule: Host(\`${DOMAIN_ORG:?}\`)
      middlewares: ["KHFrontendRedirectToLangEN"]
      service: kh-demo-frontend-${HOSTNAME:?}@docker
      tls:
        certResolver: le-tls
EOF
