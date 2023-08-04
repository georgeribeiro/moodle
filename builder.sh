#!/bin/bash

set -ex

REGISTRY=georgeribeiro
IMAGE_NAME=moodle
CURRENT_DIR="$(dirname $0)"
TAG="${1:-latest}"

docker build ${CURRENT_DIR} -t $IMAGE_NAME:$TAG
docker tag $IMAGE_NAME $REGISTRY/$IMAGE_NAME:$TAG
docker push $REGISTRY/$IMAGE_NAME:$TAG
