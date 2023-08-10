#!/usr/bin/env bash 

docker run -td \
  -v "$(pwd):/sbtn-dist" \
  -w "/sbtn-dist" \
  --env PGP_SECRET \
  --env PGP_PASSPHRASE \
  --env GPG_EMAIL \
  --env KEYGRIP \
  --privileged \
  fedora \
  "sh ./updateRpmPackages.sh"
