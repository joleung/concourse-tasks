#!//bin/sh
ACME_SERVER=acme-v02.api.letsencrypt.org
if [ -n "${STAGING}" ]; then
  ACME_SERVER="acme-staging-v02.api.letsencrypt.org"
  echo "Using staging server ${ACME_SERVER}"
fi

echo "${CLOUDFLARE_INI}" > cloudflare.ini;
chmod 600 cloudflare.ini;

certbot certonly -n --dns-cloudflare \
--agree-tos --email ${CERTBOT_EMAIL} \
--dns-cloudflare-credentials cloudflare.ini \
--dns-cloudflare-propagation-seconds 30 \
--server https://${ACME_SERVER}/directory \
--key-type rsa \
-d "${CERT_DOMAIN}";
cp -RL /etc/letsencrypt/live/${CERT_DOMAIN}/* certoutput;

