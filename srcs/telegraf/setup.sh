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
	kubectl apply -f telegraf-deployment.yaml
}

delete ()
{
	kubectl delete -f telegraf-deployment.yaml
}

create_image ()
{
	docker image build -t telegraf .
	check_fail
}

eval $1
