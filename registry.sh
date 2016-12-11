#!/bin/bash
docker rm -f aws
docker pull cgswong/aws:aws

PROVIDER="AWS"
INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
PUBLIC_IPV4=$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)
PR_IPV4=$(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)
HOST=$(curl -s http://169.254.169.254/latest/meta-data/public-hostname)
REGION=$(curl -s http://169.254.169.254/latest/dynamic/instance-identity/document | jq -r ".region")

EXIST_NODE=$(docker run -i --name aws -v /home/core/.aws:/root/.aws cgswong/aws:aws ec2 describe-instances --filters Name=instance-id,Values=${INSTANCE_ID} | jq -r ".Reservations[].Instances[]")
docker rm -f aws
STACK=$(echo ${EXIST_NODE} | jq '.Tags[] | select(.Key == "Stack")'  | jq  -r ".Value" )
SERVICE_TYPE=$(echo ${EXIST_NODE} | jq '.Tags[] | select(.Key == "Type")'  | jq  -r ".Value" )
ROLE=$(echo ${EXIST_NODE} | jq '.Tags[] | select(.Key == "Role")'  | jq  -r ".Value" )


echo PR_IP="$PR_IPV4"                    >> /etc/docker/environments
echo STACK="$STACK"                      >> /etc/docker/environments
echo SERVICE_TYPE="$SERVICE_TYPE"        >> /etc/docker/environments
echo INSTANCE_ID="$INSTANCE_ID"          >> /etc/docker/environments
echo REGION="$REGION"                    >> /etc/docker/environments
echo PROVIDER="$PROVIDER"                >> /etc/docker/environments
echo SD_BOOT="$SD_BOOT"                  >> /etc/docker/environments

groupadd -r docker
usermod -a -G docker newrelic
