#!/bin/sh
# Wildcard certificate
if "${WILDCARD_CERT}"; then
  CERT_DOMAINS+=", *.${CERT_DOMAINS}"
fi

# Production server
ACME_SERVER=acme-v02.api.letsencrypt.org
if "${STAGING}"; then
  ACME_SERVER="acme-staging-v02.api.letsencrypt.org" # Staging server
  echo "Using staging server ${ACME_SERVER}"
fi

IFS=', ' read -r -a DOMAIN_NAME <<< "${CERT_DOMAINS}"

# Subject Alternative Name (SAN) certificate
DOMAIN_CERTBOT_PARAM=""
for d in ${DOMAIN_NAME[@]}
do
  DOMAIN_CERTBOT_PARAM="${DOMAIN_CERTBOT_PARAM} -d \"${d}\" ";
done

echo "${CLOUDFLARE_INI}" > cloudflare.ini;
chmod 600 cloudflare.ini;

certbot certonly -n --dns-cloudflare \
--agree-tos --email ${CERTBOT_EMAIL} \
--dns-cloudflare-credentials cloudflare.ini \
--dns-cloudflare-propagation-seconds 30 \
--server https://${ACME_SERVER}/directory \
--key-type rsa ${DOMAIN_CERTBOT_PARAM};
cp -RL /etc/letsencrypt/live/${DOMAIN_NAME[0]}/* certoutput;

