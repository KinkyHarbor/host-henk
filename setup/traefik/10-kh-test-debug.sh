#!/usr/bin/env bash

# Variables
ENV_FILE=${HOME}/henk/.env
TRAEFIK_DIR=${HOME}/henk/conf/traefik

# Load env
source "${ENV_FILE}"

# Kinky Harbor: Debug Mongo
tee ${TRAEFIK_DIR:?}/kh-test-debug-mongo.yml <<EOF
http:
  routers:
    KHTestDebugMongo:
      entryPoints: ["websecure"]
      rule: Host(\`test-mongo.${DEFAULT_DOMAIN:?}\`)
      service: kh-test-mongo-express-${HOSTNAME:?}@docker
      tls:
        certResolver: le-tls
EOF

# Kinky Harbor: Debug Flower
tee ${TRAEFIK_DIR:?}/kh-test-debug-flower.yml <<EOF
http:
  routers:
    KHTestDebugFlower:
      entryPoints: ["websecure"]
      rule: Host(\`test-flower.${DEFAULT_DOMAIN:?}\`)
      service: kh-test-flower-${HOSTNAME:?}@docker
      tls:
        certResolver: le-tls
EOF
