SHELL := /bin/bash

ifndef APPLICATION_NAME
$(error APPLICATION_NAME is not set)
endif
ifndef AWS_REGION
$(error AWS_REGION is not set)
endif

requires-environment-set:
	@if [ -z $(ENVIRONMENT) ]; then >&2 echo "ENVIRONMENT is not set"; exit 255; fi

kube-cluster: requires-environment-set
	envsubst < eksctl-cluster-template.yml > $(ENVIRONMENT)-eksctl-cluster-template-processed.yml
	- eksctl create cluster -f $(ENVIRONMENT)-eksctl-cluster-template-processed.yml