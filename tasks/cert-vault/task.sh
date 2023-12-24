#!/bin/sh
domain_name=`cat domaininfo/firstdomain.txt`
vault kv put ${VAULT_PATH}/${domain_name} cert=@certoutput/cert.pem chain=@certoutput/chain.pem fullchain=@certoutput/fullchain.pem key=@certoutput/privkey.pem
