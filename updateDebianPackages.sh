#!/usr/bin/env bash 
set -euo pipefail

mv ./artifacts/*.deb ./debian
cd ./debian

DIST_DIR="dists/all/main/binary-all"
mkdir -p "$DIST_DIR" || true

apt-ftparchive packages . > dists/all/main/binary-all/Packages
apt-ftparchive release . > dists/all/Release
gzip -k -f dists/all/main/binary-all/Packages > dists/all/main/binary-all/Packages.gz
bzip2 -k -f dists/all/main/binary-all/Packages > dists/all/main/binary-all/Packages.bz2

echo ${PGP_PASSPHRASE} | gpg --batch --yes --passphrase-fd 0 --default-key "${KEYNAME}" -abs -o - dists/all/Release > dists/all/Release.gpg
echo ${PGP_PASSPHRASE} | gpg --batch --yes --passphrase-fd 0 --default-key "${KEYNAME}" --clearsign -o - dists/all/Release > dists/all/InRelease
