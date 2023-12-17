#!/usr/bin/env bash
set -eux
echo "${CLOUDFLARE_INI}" > cloudflare.ini;
chmod 600 cloudflare.ini;
certbot certonly -n --dns-cloudflare \
--agree-tos --email ${CERTBOT_EMAIL} \
--dns-cloudflare-credentials cloudflare.ini \
--dns-cloudflare-propagation-seconds 30 \
--server https://acme-staging-v02.api.letsencrypt.org/directory \
--key-type rsa \
-d "${CERT_DOMAIN}";
cp -RL /etc/letsencrypt/live/${CERT_DOMAIN}/* certoutput;

