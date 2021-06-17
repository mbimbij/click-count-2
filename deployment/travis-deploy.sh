#!/bin/bash

if [ -z $1 ]; then
  echo -e "usage:\n./travis-deploy.sh \$ENVIRONMENT"
  exit 1
fi

ENVIRONMENT=$1

aws eks update-kubeconfig --name click-count-$ENVIRONMENT
kubectl get nodes
ls