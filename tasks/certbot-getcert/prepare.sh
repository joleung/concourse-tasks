#!/bin/bash
IFS=', ' read -r -a DOMAIN_NAME <<< "${CERT_DOMAINS}"

DOMAIN_CERTBOT_PARAM=""
for d0 in ${DOMAIN_NAME[@]}
do
  dp=" -d \"${d0}\" "
  if "${WILDCARD_CERT}"; then
    dp+=" -d \"*.${d0}\" "
  fi
  DOMAIN_CERTBOT_PARAM="${DOMAIN_CERTBOT_PARAM} ${dp}";
done
echo ${DOMAIN_CERTBOT_PARAM} > domaininfo/domain_params.txt