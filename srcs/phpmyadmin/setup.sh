#!/bin/sh

check_fail ()
{
	if [ $? -ne 0 ]
	then exit $?
	fi
}

add ()
{
	kubectl apply -f pma-deployment.yaml
	kubectl apply -f pma-service.yaml
}

delete ()
{
	kubectl delete -f pma-deployment.yaml
	kubectl delete -f pma-service.yaml
}

create_image ()
{
	docker image build -t pma .
	check_fail
}

eval $1
