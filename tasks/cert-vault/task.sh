#!/bin/sh
vault kv put ${VAULT_PATH}/${CERT_DOMAIN} cert=@certoutput/fullchain.pem key=@certoutput/privkey.pem
