#!/bin/bash

if [ -z $1 ]; then
  echo -e "usage:\n./travis-deploy.sh \$ENVIRONMENT"
  exit 1
fi

ENVIRONMENT=$1
cd "$(dirname "$0")" || exit 255

aws eks update-kubeconfig --name click-count-$ENVIRONMENT
helm upgrade -i --debug click-count ./helm-chart \
  --set application.name=click-count \
  --set redis.host=localhost \
  --set redis.port=6379 \
  --set imageUrl=cless91/click-count \
  --set imageTag=latest