#!/bin/sh

check_fail ()
{
	if [ $? -ne 0 ]
	then exit $?
	fi
}

add ()
{
	kubectl apply -f wp-deployment.yaml
	kubectl apply -f wp-service.yaml
}

delete ()
{
	kubectl delete -f wp-deployment.yaml
	kubectl delete -f wp-service.yaml
}

create_image ()
{
	docker image build -t wp .
	check_fail
}

eval $1
