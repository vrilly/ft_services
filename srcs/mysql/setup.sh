#!/bin/sh

check_fail ()
{
	if [ $? -ne 0 ]
	then exit $?
	fi
}

add ()
{
	kubectl apply -f mysql-deployment.yaml
	kubectl apply -f mysql-service.yaml
}

delete ()
{
	kubectl delete -f mysql-deployment.yaml
	kubectl delete -f mysql-service.yaml
}

create_image ()
{
	docker image build -t mariadb .
	check_fail
}

eval $1
