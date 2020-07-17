#!/bin/sh

check_fail ()
{
	if [ $? -ne 0 ]
	then exit $?
	fi
}

add ()
{
	kubectl apply -f ftps-deployment.yaml
	kubectl apply -f ftps-service.yaml
}

delete ()
{
	kubectl delete -f ftps-deployment.yaml
	kubectl delete -f ftps-service.yaml
	rm ftps-service.yaml
}

create_image ()
{
	sed "s/_MINIKUBE_IP_/$MINIKUBE_IP/g" \
		vsftpd.conf.template > vsftpd.conf
	sed "s/_MINIKUBE_IP_/$MINIKUBE_IP/g" \
		ftps-service.yaml.template > ftps-service.yaml
	docker image build -t vsftpd .
	check_fail
	rm vsftpd.conf
}

eval $1
