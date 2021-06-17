#!/bin/bash

echo "coucou"
aws sts get-caller-identity --output text
kubectl version