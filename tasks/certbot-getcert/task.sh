#!/bin/bash
# Production server
acme_server=acme-v02.api.letsencrypt.org
if "${STAGING}"; then
  acme_server="acme-staging-v02.api.letsencrypt.org" # Staging server
  echo "Using staging server ${acme_server}"
fi

domain_certbot_params=`cat domaininfo/domain_params.txt`
domain_name=`cat domaininfo/firstdomain.txt`

echo "${CLOUDFLARE_INI}" > cloudflare.ini;
chmod 600 cloudflare.ini;

certbot certonly -n --dns-cloudflare \
--agree-tos --email ${CERTBOT_EMAIL} \
--dns-cloudflare-credentials cloudflare.ini \
--dns-cloudflare-propagation-seconds 30 \
--server https://${acme_server}/directory \
--key-type rsa ${domain_certbot_params};
cp -RL /etc/letsencrypt/live/${domain_name}/* certoutput;

