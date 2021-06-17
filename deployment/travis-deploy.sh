#!/bin/bash

echo "coucou"
aws sts get-caller-identity --output text
aws eks update-kubeconfig --name click-count-staging
kubectl get nodes
ls