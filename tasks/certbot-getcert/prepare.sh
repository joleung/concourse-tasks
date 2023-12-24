#!/bin/bash
IFS=', ' read -r -a domain_name <<< "${CERT_DOMAINS}"

domain_cert_param=""
for d0 in ${domain_name[@]}
do
  dp=" -d \"${d0}\" "
  if "${WILDCARD_CERT}"; then
    dp+=" -d \"*.${d0}\" "
  fi
  domain_cert_param="${domain_cert_param} ${dp}";
done
echo ${domain_cert_param} > domaininfo/domain_params.txt
echo ${domain_name[0]} > domaininfo/firstdomain.txt