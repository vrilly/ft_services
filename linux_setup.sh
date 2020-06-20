#!/bin/sh

killall minikube
minikube delete
minikube start --extra-config=apiserver.service-node-port-range=1-10000
minikube dashboard &
sleep 10
eval $(minikube docker-env)
MINIKUBE_IP=$(minikube ip)
sed "s/_MINIKUBE_IP_/$MINIKUBE_IP/g" srcs/ftps/vsftpd.conf.template > srcs/ftps/vsftpd.conf
docker image build -t vsftpd-server srcs/ftps
rm srcs/ftps/vsftpd.conf
kubectl apply -f srcs/ftps/ftps-service.yaml
kubectl apply -f srcs/ftps/ftps-deployment.yaml
echo "deployment done on $MINIKUBE_IP"
