#!/usr/bin/env bash

docker run -td \
  -v "$(pwd)/debian:/artifactory/debian" \
  ubuntu \
  bash

