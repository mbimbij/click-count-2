#!/bin/bash

if [ -z $3 ]; then
  echo -e "usage:\n./travis-deploy.sh \$ENVIRONMENT \$IMAGE_NAME \$IMAGE_TAG"
  exit 1
fi

ENVIRONMENT=$1
IMAGE_NAME=$2
IMAGE_TAG=$3

cd "$(dirname "$0")" || exit 255

REDIS_ADDRESS=$(aws ssm get-parameter --name /click-count/$ENVIRONMENT/redis/address --query "Parameter.Value" --output text)
REDIS_PORT=$(aws ssm get-parameter --name /click-count/$ENVIRONMENT/redis/port --query "Parameter.Value" --output text)
KUBE_CLUSTER_NAME=click-count-$ENVIRONMENT

aws eks update-kubeconfig --name $KUBE_CLUSTER_NAME
helm upgrade -i --debug click-count ./helm-chart \
  --set application.name=click-count \
  --set redis.address=$REDIS_ADDRESS \
  --set redis.port=$REDIS_PORT \
  --set imageUrl=$IMAGE_NAME \
  --set imageTag=$IMAGE_TAG