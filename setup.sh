#!/bin/sh

if [[ "$OSTYPE" == "darwin"* ]]; then
	if ! [ -x "$(command -v brew)" ]; then
		echo "Please install brew first" >&2
		exit 1
	fi

	if ! [ -x "$(command -v dialog)" ]; then
		brew install dialog
	fi

	if ! [ -x "$(command -v minikube)" ]; then
		brew install minikube
	fi
fi

if [ -n "$1" ]
then
	echo "Log of cmd $0 $1 at $(date)" > log.txt
	./minikube_setup.sh $1
else
	exec 3>&1
	ACTION=$(dialog --menu "ft_services menu" 24 -1 -1 \
		setup "Setup minikube cluster" \
		update "Delete and apply all deployments" \
		delete "Destroy minikube cluster" \
		dashboard "Launch dashboard" \
		2>&1 1>&3)
	if [ $? -ne 0 ]
	then exit 0
	fi
	eval $0 $ACTION
fi
