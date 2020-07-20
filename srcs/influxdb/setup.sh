#!/bin/sh

check_fail ()
{
	if [ $? -ne 0 ]
	then exit $?
	fi
}

add ()
{
	kubectl apply -f influxdb-volume.yaml
	kubectl apply -f influxdb-deployment.yaml
	kubectl apply -f influxdb-service.yaml
}

delete ()
{
	kubectl delete -f influxdb-deployment.yaml
	kubectl delete -f influxdb-service.yaml
}

create_image ()
{
	docker image build -t influxdb .
	check_fail
}

eval $1
