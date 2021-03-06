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
	kubectl apply -f webserver-deployment.yaml
	kubectl apply -f webserver-service.yaml
}

delete ()
{
	kubectl delete -f webserver-deployment.yaml
	kubectl delete -f webserver-service.yaml
}

create_image ()
{
	cp ~/.ssh/id_rsa.pub .
	docker image build -t nginx .
	check_fail
}

eval $1
