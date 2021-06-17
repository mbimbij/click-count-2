#!/bin/bash

if [ -z $3 ]; then
  echo -e "usage:\n./travis-deploy.sh \$ENVIRONMENT \$IMAGE_NAME \$IMAGE_TAG"
  exit 1
fi

ENVIRONMENT=$1
IMAGE_NAME=$2
IMAGE_TAG=$3

cd "$(dirname "$0")" || exit 255

aws eks update-kubeconfig --name click-count-$ENVIRONMENT
helm upgrade -i --debug click-count ./helm-chart \
  --set application.name=click-count \
  --set redis.host=localhost \
  --set redis.port=6379 \
  --set imageUrl=$IMAGE_NAME \
  --set imageTag=$IMAGE_TAG