#!/bin/sh

set -ex

REGISTRY=200.129.37.136:5000
IMAGE_NAME=moodle

docker build $(dirname $0) -t $IMAGE_NAME
docker tag $IMAGE_NAME $REGISTRY/$IMAGE_NAME
docker push $REGISTRY/$IMAGE_NAME
