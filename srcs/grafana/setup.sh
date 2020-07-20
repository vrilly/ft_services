#!/bin/sh

check_fail ()
{
	if [ $? -ne 0 ]
	then exit $?
	fi
}

add ()
{
	kubectl apply -f grafana-deployment.yaml
	kubectl apply -f grafana-service.yaml
}

delete ()
{
	kubectl delete -f grafana-deployment.yaml
	kubectl delete -f grafana-service.yaml
}

create_image ()
{
	docker image build -t grafana .
	check_fail
}

eval $1
