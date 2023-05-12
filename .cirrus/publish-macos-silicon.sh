#!/bin/bash -ex

# Branch of sbt to build
BRANCH_TO_BUILD=1.8.x

# Set up sbt and a JDK
brew install sbt

# Clone sbt repository
git clone --branch $BRANCH_TO_BUILD https://github.com/sbt/sbt.git
cd sbt

# Build sbtn native image
sbt clean nativeImage

if [[ "$CIRRUS_TAG" == "" ]]; then
  echo "No tag set. Stopping."
  exit 0
fi

if [[ "$GITHUB_TOKEN" == "" ]]; then
  echo "Please provide GitHub access token via GITHUB_TOKEN environment variable!"
  exit 1
fi

# Find the corresponding release in the sbt/sbt repository
CURL_RESULT=$(curl --location --fail --silent \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $GITHUB_TOKEN"\
  -H "X-GitHub-Api-Version: 2022-11-28" \
  "https://api.github.com/repos/sbt/sbt/releases/tags/$CIRRUS_TAG")

if [[ "$?" -ne 0 ]]; then
  echo "Release $CIRRUS_TAG not found in repository sbt/sbt."
  exit 1
fi

RELEASE=$(echo $CURL_RESULT | jq '.id')

file_content_type="application/octet-stream"
fpath=client/target/bin/sbtn
name=sbtn-aarch64-apple-darwin

echo "Uploading $fpath..."
name="$(basename "$fpath")-"
url_to_upload="https://uploads.github.com/repos/sbt/sbt/releases/$RELEASE/assets?name=$name"
curl -X POST \
  --data-binary @$fpath \
  --header "Authorization: Bearer $GITHUB_TOKEN" \
  --header "Content-Type: $file_content_type" \
  $url_to_upload

if [[ "$?" -ne 0 ]]; then
  echo "Asset upload failed."
  exit 1
fi
