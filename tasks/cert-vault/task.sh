#!/bin/sh
vault kv put ${VAULT_PATH}/${CERT_DOMAIN} cert=@certoutput/cert.pem chain=@certoutput/chain.pem fullchain=@certoutput/fullchain.pem key=@certoutput/privkey.pem
