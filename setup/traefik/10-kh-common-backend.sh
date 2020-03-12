#!/usr/bin/env bash

# Variables
ENV_FILE=${HOME}/henk/.env
TRAEFIK_DIR=${HOME}/henk/conf/traefik

# Load env
source "${ENV_FILE}"

# Kinky Harbor: Backend
tee ${TRAEFIK_DIR:?}/kh-common-backend.yml <<EOF
http:
  middlewares:
    KHBackendRedirectToDemo:
      redirectRegex:
        regex: "^https?://(.*\\\\.)?kinkyharbor\\\\..*?/(.*)"
        replacement: "https://demo-api.${DEFAULT_DOMAIN}/\${2}"
EOF
