#!/usr/bin/env bash 
set -euo pipefail

TARGET_DIR="./debian/dists/all/main"

mv ./artifacts/*.deb ./debian/pool/main || true

mkdir -p "$TARGET_DIR/binary-all" || true

rm ./debian-cache/packages-main-all.db || true
rm -r "$TARGET_DIR/by-hash" || true
rm -r "$TARGET_DIR/binary-all/by-hash" || true

apt-ftparchive generate apt-ftparchive-generate.conf
apt-ftparchive -c apt-ftparchive-release.conf release . > debian/dists/all/Release

compute_hashes() {
    local file="$1"
    local dir="$(dirname "$file")"

    # Compute hashes
    local md5=$(md5sum "$file" | cut -f1 -d' ')
    local sha1=$(sha1sum "$file" | cut -f1 -d' ')
    local sha256=$(sha256sum "$file" | cut -f1 -d' ')
    local sha512=$(sha512sum "$file" | cut -f1 -d' ')

    # Create by-hash directories and copy files
    for hash in "MD5Sum" "SHA1" "SHA256" "SHA512"; do
        mkdir -p "${dir}/by-hash/${hash}"
    done

    cp "$file" "${dir}/by-hash/MD5Sum/${md5}"
    cp "$file" "${dir}/by-hash/SHA1/${sha1}"
    cp "$file" "${dir}/by-hash/SHA256/${sha256}"
    cp "$file" "${dir}/by-hash/SHA512/${sha512}"
}

files_to_process=()
while IFS= read -d $'\0' -r file; do
    files_to_process+=("$file")
done < <(find $TARGET_DIR -type f -print0)

for file in "${files_to_process[@]}"; do
    compute_hashes "$file"
done

echo ${PGP_PASSPHRASE} | gpg --batch --yes --passphrase-fd 0 --default-key "${KEYNAME}" -abs -o - debian/dists/all/Release > debian/dists/all/Release.gpg
echo ${PGP_PASSPHRASE} | gpg --batch --yes --passphrase-fd 0 --default-key "${KEYNAME}" --clearsign -o - debian/dists/all/Release > debian/dists/all/InRelease
