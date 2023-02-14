#!/bin/bash -ex

brew install sbt

git clone --branch try-cirrus-ci https://github.com/scalacenter/sbt.git

cd sbt

sbt clean nativeImage

if [[ "$CIRRUS_RELEASE" == "" ]]; then
  echo "Not a release. No need to deploy!"
  exit 0
fi

if [[ "$GITHUB_TOKEN" == "" ]]; then
  echo "Please provide GitHub access token via GITHUB_TOKEN environment variable!"
  exit 1
fi

file_content_type="application/octet-stream"
fpath=client/target/bin/sbtn
name=sbtn-aarch64-apple-darwin

echo "Uploading $fpath..."
name="$(basename "$fpath")-"
url_to_upload="https://uploads.github.com/repos/$CIRRUS_REPO_FULL_NAME/releases/$CIRRUS_RELEASE/assets?name=$name"
curl -X POST \
  --data-binary @$fpath \
  --header "Authorization: token $GITHUB_TOKEN" \
  --header "Content-Type: $file_content_type" \
  $url_to_upload
