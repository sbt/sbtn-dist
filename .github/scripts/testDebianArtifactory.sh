#!/usr/bin/env bash

SCRIPT="echo \"deb [arch=all] file:/artifactory/debian all main\" > /etc/apt/sources.list.d/scala-archive.list &&
  cp /artifactory/debian/scala-archive-keyring.gpg /etc/apt/trusted.gpg.d/ &&
  apt update &&
  apt install -y curl default-jdk sbt &&
  cd ~/ &&
  sbt new scala/scala3.g8 --name=sbt-test &&
  cd sbt-test &&
  sbt run
"

docker run \
  -v "$(pwd)/debian:/artifactory/debian" \
  --rm \
  ubuntu \
  sh -c "$SCRIPT"
