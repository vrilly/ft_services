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
	kubectl apply -f mysql-volume.yaml
	kubectl apply -f mysql-deployment.yaml
	kubectl apply -f mysql-service.yaml
}

delete ()
{
	kubectl delete -f mysql-deployment.yaml
	kubectl delete -f mysql-service.yaml
	kubectl delete -f mysql-volume.yaml
}

create_image ()
{
	docker image build -t mariadb .
	check_fail
}

eval $1
