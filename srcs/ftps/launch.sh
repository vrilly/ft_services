#!/bin/sh

sleep 5
CA_CERT=/var/run/secrets/kubernetes.io/serviceaccount/ca.crt
BEARER=$(cat /var/run/secrets/kubernetes.io/serviceaccount/token)
STAT_URL=https://kubernetes/api/v1/namespaces/default/services/ftps
IP=$(curl --cacert "$CA_CERT" -H "Authorization: Bearer $BEARER" "$STAT_URL" | jq -r '.status.loadBalancer.ingress[0].ip')
echo "pasv_address=$IP" >> /etc/vsftpd.conf
/usr/sbin/vsftpd
