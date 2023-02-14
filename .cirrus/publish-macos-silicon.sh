#!/bin/bash -ex

brew install sbt

git clone --branch try-cirrus-ci https://github.com/scalacenter/sbt.git

cd sbt

sbt clean nativeImage
