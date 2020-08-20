#!/usr/bin/env bash
set -eo pipefail

. ./.environment



docker build --file ./ubuntu-18.04-unpinned.dockerfile \
  --tag $ORG/$REPO:temp \
  --compress --force-rm --no-cache \
  .
docker tag $ORG/$REPO:temp $ORG/$REPO:ubuntu-18.04-$VERSION
docker tag $ORG/$REPO:temp $ORG/$REPO:latest
docker push $ORG/$REPO:ubuntu-18.04-$VERSION
docker push $ORG/$REPO:latest



docker build --file ./amazon_linux-2-unpinned.dockerfile \
  --tag $ORG/$REPO:temp \
  --compress --force-rm --no-cache \
  .
docker tag $ORG/$REPO:temp $ORG/$REPO:amazon_linux-2-$VERSION
docker push $ORG/$REPO:amazon_linux-2-$VERSION



docker build --file ./centos-7.7-unpinned.dockerfile \
  --tag $ORG/$REPO:temp \
  --compress --force-rm --no-cache \
  .
docker tag $ORG/$REPO:temp $ORG/$REPO:centos-7.7-$VERSION
docker push $ORG/$REPO:centos-7.7-$VERSION
