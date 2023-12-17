#!/bin/sh
set -eux
echo "${CLOUDFLARE_INI}" > cloudflare.ini;
cat cloudflare.ini;
