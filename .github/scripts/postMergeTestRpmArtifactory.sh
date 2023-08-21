#!/usr/bin/env bash

SCRIPT="curl -sS \"https://repo.scala-sbt.org/scalasbt/rpm/scala-archive.repo\" > /etc/yum.repos.d/scala-archive.repo &&
  yum update -y &&
  yum install -y curl java-17-openjdk-devel sbt &&
  cd ~/ &&
  sbt new scala/scala3.g8 --name=sbt-test &&
  cd sbt-test &&
  sbt run
"

docker run \
  --rm \
  fedora \
  sh -c "$SCRIPT"
