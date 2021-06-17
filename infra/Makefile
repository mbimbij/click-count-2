SHELL := /bin/bash

ifndef AWS_REGION
$(error AWS_REGION is not set)
endif

AWS_ACCOUNT_ID := $(shell aws sts get-caller-identity --query "Account" --output text)

requires-environment-set:
	@if [ -z $(ENVIRONMENT) ]; then >&2 echo "ENVIRONMENT is not set"; exit 255; fi

kube-cluster-staging:
	$(MAKE) kube-cluster ENVIRONMENT=staging
kube-cluster-production:
	$(MAKE) kube-cluster ENVIRONMENT=production
kube-cluster: requires-environment-set
	envsubst < eksctl-cluster-template.yml > $(ENVIRONMENT)-eksctl-cluster-template-processed.yml
	- eksctl create cluster -f $(ENVIRONMENT)-eksctl-cluster-template-processed.yml
	eksctl create iamidentitymapping \
		--cluster click-count-$(ENVIRONMENT) \
		--arn arn:aws:iam::$(AWS_ACCOUNT_ID):user/travis-deployer \
		--group system:masters \
		--username travis-deployer
delete-kube-cluster-staging:
	$(MAKE) delete-kube-cluster ENVIRONMENT=staging
delete-kube-cluster-production:
	$(MAKE) delete-kube-cluster ENVIRONMENT=production
delete-kube-cluster: requires-environment-set
	eksctl delete cluster click-count-$(ENVIRONMENT)


redis-cluster-staging:
	$(MAKE) redis-cluster ENVIRONMENT=staging
redis-cluster-production:
	$(MAKE) redis-cluster ENVIRONMENT=production
redis-cluster: requires-environment-set
	$(eval VPC_ID := $(shell aws cloudformation list-exports --region $(AWS_REGION) --query "Exports[?Name=='eksctl-click-count-$(ENVIRONMENT)-cluster::VPC'].Value" --output text))
	$(eval PRIVATE_SUBNET_IDS := $(shell aws cloudformation list-exports --region $(AWS_REGION) --query "Exports[?Name=='eksctl-click-count-$(ENVIRONMENT)-cluster::SubnetsPrivate'].Value" --output text))
	$(eval SECURITY_GROUP_ID := $(shell aws cloudformation list-exports --region $(AWS_REGION) --query "Exports[?Name=='eksctl-click-count-$(ENVIRONMENT)-cluster::SharedNodeSecurityGroup'].Value" --output text))
	aws cloudformation deploy    \
		--stack-name click-count-$(ENVIRONMENT)-redis   \
		--template-file redis-cluster-cfn.yml    \
		--parameter-overrides  \
			ApplicationName=click-count \
			Environment=$(ENVIRONMENT) \
			VpcId=$(VPC_ID) \
			SubnetIds=$(PRIVATE_SUBNET_IDS) \
			ApplicationSecurityGroupId=$(SECURITY_GROUP_ID)
delete-redis-cluster-staging:
	$(MAKE) delete-redis-cluster ENVIRONMENT=staging
delete-redis-cluster-production:
	$(MAKE) delete-redis-cluster ENVIRONMENT=production
delete-redis-cluster: requires-environment-set
	./stack-deletion/delete-stack-wait-termination.sh click-count-$(ENVIRONMENT)-redis


environment-staging:
	$(MAKE) environment ENVIRONMENT=staging
environment-production:
	$(MAKE) environment ENVIRONMENT=production
environment: requires-environment-set
	- $(MAKE) kube-cluster ENVIRONMENT=$(ENVIRONMENT)
	$(MAKE) redis-cluster ENVIRONMENT=$(ENVIRONMENT)
delete-environment-staging:
	$(MAKE) delete-environment ENVIRONMENT=staging
delete-environment-production:
	$(MAKE) delete-environment ENVIRONMENT=production
delete-environment: requires-environment-set
	$(MAKE) delete-redis-cluster ENVIRONMENT=$(ENVIRONMENT)
	$(MAKE) delete-kube-cluster ENVIRONMENT=$(ENVIRONMENT)

delete-all:
	$(MAKE) -j2 delete-environment-staging delete-environment-production