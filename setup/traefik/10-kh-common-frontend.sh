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
    KHFrontendRedirectToDemo:
      redirectRegex:
        regex: "^https?://(.*\\\\.)?kinkyharbor\\\\.(.*?)/(.*)"
        replacement: "https://demo.kinkyharbor.\${2}/\${3}"

    KHFrontendRedirectToLangEN:
      redirectRegex:
        regex: "^https?://(.*\\\\.)?kinkyharbor\\\\..*?/(.*)"
        replacement: "https://\${DEFAULT_DOMAIN}/\${2}"

    KHFrontendRedirectToLangNL:
      redirectRegex:
        regex: "^https?://(.*\\\\.)?kinkyharbor\\\\..*?/(.*)"
        replacement: "https://\${DEFAULT_DOMAIN}/nl/\${2}"
EOF
