#!/bin/sh

STATUS_WAITING="Queued"
STATUS_INIT="Building"
STATUS_START="Starting"

NAME[0]="Minikube cluster"
NAME[1]="Dashboard"
NAME[2]="Load balancer"
NAME[3]="FTP Server"
NAME[4]="MYSQL Server"

DIR[2]=srcs/load_balancer
DIR[3]=srcs/ftps
DIR[4]=srcs/mysql

STATUS[0]="$STATUS_WAITING"
STATUS[1]="$STATUS_WAITING"
STATUS[2]="$STATUS_WAITING"
STATUS[3]="$STATUS_WAITING"
STATUS[4]="$STATUS_WAITING"

PROGRESS=0
PROG_STEP=20

exec_dialog ()
{
	dialog \
		--mixedgauge "$(tail -n5 log.txt)" 20 80 $PROGRESS \
	"${NAME[0]}" "${STATUS[0]}" \
	"${NAME[1]}" "${STATUS[1]}" \
	"${NAME[2]}" "${STATUS[2]}" \
	"${NAME[3]}" "${STATUS[3]}" \
	"${NAME[4]}" "${STATUS[4]}"
}

delete ()
{
	killall -q minikube
	minikube delete
}

update ()
{
	export MINIKUBE_IP=$(minikube ip)
	eval $(minikube -p minikube docker-env)
	((PROGRESS += 2*PROG_STEP))
	setup_pods rmfirst
}

setup_pods ()
{
	counter=2
	while [ $counter -le 4 ]
	do
		STATUS[$counter]=$STATUS_INIT
		exec_dialog
		cd ${DIR[$counter]}
		if [ -n "$1" ]
		then ./setup.sh delete &>>../../log.txt
		fi
		./setup.sh create_image &>>../../log.txt
		./setup.sh add &>>../../log.txt
		cd ../..
		STATUS[$counter]=0
		((PROGRESS += PROG_STEP))
		exec_dialog
		((counter++))
	done
}

dashboard ()
{
	minikube dashboard
}

setup ()
{
	STATUS[0]="$STATUS_INIT"
	delete
	exec_dialog
	minikube start &>>log.txt
	if [ $? -ne 0 ]
	then exit $?
	fi
	STATUS[0]=$?
	STATUS[1]=$STATUS_INIT
	((PROGRESS += POG_STEP))
	minikube dashboard &>>log.txt &
	exec_dialog
	sleep 15
	STATUS[1]=0
	((PROGRESS += POG_STEP))
	exec_dialog
	export MINIKUBE_IP=$(minikube ip)
	eval $(minikube -p minikube docker-env)
	setup_pods
	dialog --msgbox "Cluster IP: $MINIKUBE_IP\nSuccess!" \
		0 0
}

eval $1
