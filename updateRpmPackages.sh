#!/bin/bash
set -euo pipefail

mv ./artifacts/*.rpm ./rpm || true

echo $PGP_SECRET | base64 --decode | gpg --import --no-tty --batch --yes

echo "allow-loopback-pinentry
allow-preset-passphrase" >>~/.gnupg/gpg-agent.conf
echo "pinentry-mode loopback" >>~/.gnupg/gpg.conf

gpg-connect-agent reloadagent /bye

yum install rpm-sign createrepo -y
# https://unix.stackexchange.com/questions/328601/rpmsign-with-cli-password-prompt
  /usr/libexec/gpg-preset-passphrase --passphrase ${PGP_PASSPHRASE} --preset ${KEYGRIP}
GPG_NAME="_gpg-name $GPG_EMAIL"

rpmsign --define "$GPG_NAME" --addsign ./rpm/*.rpm
gpg --detach-sign --armor ./rpm/repodata/repomd.xml

echo ${PGP_PASSPHRASE} | gpg --batch --yes --passphrase-fd 0 --default-key "${KEYNAME}" --clearsign -o - ./rpm/repodata/repomd.xml > ./rpm/repodata/repomd.xml.asc

createrepo ./rpm

