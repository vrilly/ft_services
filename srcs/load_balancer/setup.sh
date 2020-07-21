#!/bin/sh

check_fail ()
{
	if [ $? -ne 0 ]
	then exit $?
	fi
}

add ()
{
	kubectl apply -f metallb.yaml
	kubectl create secret generic -n metallb-system memberlist \
		--from-literal=secretkey="$(openssl rand -base64 128)"
	kubectl apply -f config.yaml
}

delete ()
{
	kubectl delete -f config.yaml
	kubectl delete -f metallb.yaml
	rm config.yaml
}

create_image ()
{
}

eval $1
