#!/usr/bin/env bash

docker run \
  -v "$(pwd):/sbtn-dist" \
  -w "/sbtn-dist" \
  -u "$(id -u):$(id -g)" \
  --env PGP_SECRET \
  --env PGP_PASSPHRASE \
  --env GPG_EMAIL \
  --env KEYGRIP \
  --privileged \
  fedora \
  sh ./updateRpmPackages.sh
