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
	kubectl apply -f metallb.yaml
	kubectl create secret generic -n metallb-system memberlist \
		--from-literal=secretkey="$(openssl rand -base64 128)"
	kubectl apply -f config.yaml
}

delete ()
{
	kubectl delete -f config.yaml
	kubectl delete -f metallb.yaml
}

create_image ()
{
	echo "done"
}

eval $1
