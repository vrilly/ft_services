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
	rm mysql-service.yaml
}

create_image ()
{
	sed "s/_MINIKUBE_IP_/$MINIKUBE_IP/g" \
		mysql-service.yaml.template > mysql-service.yaml
	docker image build -t mariadb .
	check_fail
}

eval $1
