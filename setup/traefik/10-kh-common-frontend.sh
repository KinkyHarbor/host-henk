#!/usr/bin/env bash

# Variables
ENV_FILE=${HOME}/henk/.env
TRAEFIK_DIR=${HOME}/henk/conf/traefik

# Load env
source "${ENV_FILE}"

# Kinky Harbor: Frontend
tee ${TRAEFIK_DIR:?}/kh-common-frontend.yml <<EOF
http:
  middlewares:
    KHRedirectToDemo:
      redirectRegex:
        regex: "^https?://(.*\.)?${DEFAULT_DOMAIN}/(.*)"
        replacement: "https://demo.${DEFAULT_DOMAIN}/\${1}"
EOF
