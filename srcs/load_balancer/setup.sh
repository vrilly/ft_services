#!/bin/sh

check_fail ()
{
	if [ $? -ne 0 ]
	then exit $?
	fi
}

add ()
{
	kubectl apply -f namespace.yaml
	kubectl create secret generic -n metallb-system memberlist \
		--from-literal=secretkey="$(openssl rand -base64 128)"
	kubectl apply -f metallb.yaml
}

delete ()
{
	kubectl delete -f metallb.yaml
	kubectl delete -f namespace.yaml
}

create_image ()
{
	echo "No image creation needed :)"
}

eval $1
