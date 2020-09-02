#!/bin/sh

sleep 5
CA_CERT=/var/run/secrets/kubernetes.io/serviceaccount/ca.crt
BEARER=$(cat /var/run/secrets/kubernetes.io/serviceaccount/token)
STAT_URL=https://kubernetes/api/v1/namespaces/default/services/ftps
/usr/sbin/vsftpd
