#!/usr/bin/env bash

# Variables
ENV_FILE=${HOME}/henk/.env
TRAEFIK_DIR=${HOME}/henk/conf/traefik

# Load env
source "${ENV_FILE}"

# Maintenance
tee ${TRAEFIK_DIR:?}/maintenance.yml <<EOF
http:
  routers:
    Maintenance:
      entryPoints: ["websecure"]
      rule: Host(\`maintenance.${DEFAULT_DOMAIN:?}\`)
      service: maintenance-${HOSTNAME:?}@docker
      tls:
        certResolver: le-tls
    
    Maintenance:
      entryPoints: ["websecure"]
      rule: Host(\`maintenance.${DOMAIN_BE:?}\`)
      service: maintenance-${HOSTNAME:?}@docker
      tls:
        certResolver: le-tls

    Maintenance:
      entryPoints: ["websecure"]
      rule: Host(\`maintenance.${DOMAIN_NL:?}\`)
      service: maintenance-${HOSTNAME:?}@docker
      tls:
        certResolver: le-tls
EOF
