#!/usr/bin/env bash 

echo $(pwd)
cd launcher-package

LATEST_TAG=$(git tag --sort=taggerdate | tail -1 | sed 's/^v//')
LINUX_BINARIES_FOLDER=target/linux-packages

## Create binaries
sbt -Dsbt.build.version=$LATEST_TAG -Dsbt.build.offline=false -Dsbt.build.includesbtn=false -Dsbt.build.includesbtlaunch=false rpm:packageBin debian:packageBin

## Move binaries to linux-packages folder
mkdir -p $LINUX_BINARIES_FOLDER
rm -rf "$LINUX_BINARIES_FOLDER/*"

RPM_ARTIFACT_PARENT=target/rpm/RPMS/noarch
RPM_ARTIFACT_NAME="sbt-$LATEST_TAG-0.noarch.rpm"
RPM_ARTIFACT="$RPM_ARTIFACT_PARENT/$RPM_ARTIFACT_NAME"

mv "$RPM_ARTIFACT" "$LINUX_BINARIES_FOLDER/sbt-$LATEST_TAG.rpm"

DEBIAN_ARTIFACT_PARENT=target/
DEBIAN_ARTIFACT_NAME="sbt_${LATEST_TAG}_all.deb"
DEBIAN_ARTIFACT="$DEBIAN_ARTIFACT_PARENT/$DEBIAN_ARTIFACT_NAME"

mv "$DEBIAN_ARTIFACT" "$LINUX_BINARIES_FOLDER/sbt-$LATEST_TAG.deb"
ls -lh "$LINUX_BINARIES_FOLDER"
