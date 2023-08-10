#!/usr/bin/env bash 
set -euo pipefail

cd launcher-package

LATEST_TAG=$(git tag --sort=taggerdate | tail -1 | sed 's/^v//')
LINUX_BINARIES_FOLDER=target/linux-binaries

## Create binaries
sbt -Dsbt.build.version=$LATEST_TAG -Dsbt.build.offline=true rpm:packageBin debian:packageBin

## Move binaries to linux-binaries folder
mkdir -p target/linux-binaries || true

RPM_ARTIFACT_PARENT=target/rpm/RPMS/noarch
RPM_ARTIFACT_NAME="sbt-$LATEST_TAG-0.noarch.rpm"
RPM_ARTIFACT="$RPM_ARTIFACT_PARENT/$RPM_ARTIFACT"
RPM_NEW_NAME=$(echo "$RPM_ARTIFACT_NAME" | sed -r 's/-(.*)\.(.*).rpm/.rpm/')

mv "$RPM_ARTIFACT" "$LINUX_BINARIES_FOLDER/$RPM_NEW_NAME"

DEBIAN_ARTIFACT_PARENT=target/
DEBIAN_ARTIFACT_NAME="sbt_$LATEST_TAG_all.deb"
DEBIAN_ARTIFACT="$DEBIAN_ARTIFACT_PARENT/$DEBIAN_ARTIFACT_NAME"
DEBIAN_NEW_NAME=$(echo $DEBIAN_ARTIFACT_NAME | sed 's/_all//' | sed 's/_/-/')

mv "$DEBIAN_ARTIFACT" "$LINUX_BINARIES_FOLDER/$DEBIAN_NEW_NAME"
