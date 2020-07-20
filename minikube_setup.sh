#!/bin/sh

export MINIKUBE_HOME="$HOME/goinfre"
MINIKUBE_OPT="--driver=virtualbox"

STATUS_WAITING="Queued"
STATUS_INIT="Building"
STATUS_START="Starting"

NAME[0]="Minikube cluster"
NAME[1]="Dashboard"
NAME[2]="Load balancer"
NAME[3]="FTP Server"
NAME[4]="MYSQL Server"
NAME[5]="HTTP Server"
NAME[6]="InfluxDB Server"
NAME[7]="Grafana Dashboard"

DIR[2]=srcs/load_balancer
DIR[3]=srcs/ftps
DIR[4]=srcs/mysql
DIR[5]=srcs/webserver
DIR[6]=srcs/influxdb
DIR[7]=srcs/grafana

STATUS[0]="$STATUS_WAITING"
STATUS[1]="$STATUS_WAITING"
STATUS[2]="$STATUS_WAITING"
STATUS[3]="$STATUS_WAITING"
STATUS[4]="$STATUS_WAITING"
STATUS[5]="$STATUS_WAITING"
STATUS[6]="$STATUS_WAITING"
STATUS[7]="$STATUS_WAITING"

PROGRESS=0
PROG_STEP=11

exec_dialog ()
{
	dialog \
		--mixedgauge "$(tail -n5 log.txt)" 20 80 $PROGRESS \
	"${NAME[0]}" "${STATUS[0]}" \
	"${NAME[1]}" "${STATUS[1]}" \
	"${NAME[2]}" "${STATUS[2]}" \
	"${NAME[3]}" "${STATUS[3]}" \
	"${NAME[4]}" "${STATUS[4]}" \
	"${NAME[5]}" "${STATUS[5]}" \
	"${NAME[6]}" "${STATUS[6]}" \
	"${NAME[7]}" "${STATUS[7]}"
}

delete ()
{
	killall minikube > /dev/null 2>&1
	minikube delete
	rm -rf $HOME/goinfre/.minikube
	rm -rf $HOME/.minikube
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
	while [ $counter -le 7 ]
	do
		STATUS[$counter]=$STATUS_INIT
		exec_dialog
		cd ${DIR[$counter]}
		if [ -n "$1" ]
		then
			./setup.sh delete >> ../../log.txt 2>&1
			sleep 5
		fi
		./setup.sh create_image >> ../../log.txt 2>&1
		./setup.sh add >> ../../log.txt 2>&1
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
	minikube start $MINIKUBE_OPT >> log.txt 2>&1
	ln -s $HOME/goinfre/.minikube $HOME/.minikube
	if [ $? -ne 0 ]
	then exit $?
	fi
	STATUS[0]=$?
	STATUS[1]=$STATUS_INIT
	((PROGRESS += POG_STEP))
	minikube dashboard >> log.txt 2>&1 &
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
