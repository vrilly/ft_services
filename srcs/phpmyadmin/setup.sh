#!/bin/sh

check_fail ()
{
	FAIL=$?
	if [ $FAIL -ne 0 ]
	then
		exit "$FAIL"
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
