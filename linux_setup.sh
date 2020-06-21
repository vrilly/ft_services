#!/bin/sh

delete ()
{
	killall -q minikube
	minikube delete
}

update ()
{
	MINIKUBE_IP=$(minikube ip)
	if [ $? -ne 0 ]
	then
		dialog --msgbox "No minikube cluster running, please execute setup" 8 80
		exit -1
	fi
	eval $(minikube docker-env)
	kubectl delete -f srcs/ftps/ftps-service.yaml
	kubectl delete -f srcs/ftps/ftps-deployment.yaml
	sed "s/_MINIKUBE_IP_/$MINIKUBE_IP/g" srcs/ftps/vsftpd.conf.template > srcs/ftps/vsftpd.conf
	docker image build -t vsftpd-server srcs/ftps
	rm srcs/ftps/vsftpd.conf
	kubectl apply -f srcs/ftps/ftps-service.yaml
	kubectl apply -f srcs/ftps/ftps-deployment.yaml
	echo "deployment done on $MINIKUBE_IP"
}

setup ()
{
	delete
	minikube start --extra-config=apiserver.service-node-port-range=1-10000 \
		| dialog --progressbox "Starting minikube cluster" 8 80
	if [ $? -ne 0 ]
	then exit $?
	fi
	minikube dashboard &
	dialog --infobox "Starting dashboard" 8 80
	sleep 15
	update
}

if [ -n "$1" ]
then
	eval $1
else
	exec 3>&1
	eval $(dialog --menu "ft_services menu" 24 80 60 \
		setup "Setup minikube cluster" \
		update "Delete and apply all deployments" \
		delete "Destroy minikube cluster" 2>&1 1>&3)
fi
