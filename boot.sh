#!/bin/bash
docker rm -f aws
docker pull cgswong/aws:aws

PROVIDER="AWS"
INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
PUBLIC_IPV4=$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)
PR_IPV4=$(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)
REGION=$(curl -s http://169.254.169.254/latest/dynamic/instance-identity/document | jq -r ".region")

EXIST_NODE=$(docker run -i --name aws -v /home/core/.aws:/root/.aws cgswong/aws:aws ec2 describe-instances --filters Name=instance-id,Values=${INSTANCE_ID} | jq -r ".Reservations[].Instances[]")
docker rm -f aws
STACK=$(echo ${EXIST_NODE} | jq '.Tags[] | select(.Key == "Stack")'  | jq  -r ".Value" )
SERVICE_TYPE=$(echo ${EXIST_NODE} | jq '.Tags[] | select(.Key == "Type")'  | jq  -r ".Value" )
ROLE=$(echo ${EXIST_NODE} | jq '.Tags[] | select(.Key == "Role")'  | jq  -r ".Value" )

if [ "$SERVICE_TYPE" == "swarm-manager" ] && [ "$ROLE" == "master" ]; then
   SWARM_MASTER_IP=${PR_IPV4}
   docker swarm init --advertise-addr ${PR_IPV4}
   docker run -i --name aws -v /home/core/.aws:/root/.aws cgswong/aws:aws ec2 create-tags --resources ${INSTANCE_ID} --tags Key=ManagerToken,Value=$(docker swarm join-token -q manager)
   docker rm -f aws
   docker run -i --name aws -v /home/core/.aws:/root/.aws cgswong/aws:aws ec2 create-tags --resources ${INSTANCE_ID} --tags Key=WorkerToken,Value=$(docker swarm join-token -q worker)
   docker rm -f aws
   SD_BOOT="-server -advertise ${PR_IPV4} -bootstrap"
elif [ "$SERVICE_TYPE" == "swarm-manager" ] && [ "$ROLE" == "slave" ]; then
   while [[ -z $SWARM_MASTER_NODE ]]; do
       echo 'Waiting for swarm master run ...'
       SWARM_MASTER_NODE=$(docker run -i --name aws -v /home/core/.aws:/root/.aws cgswong/aws:aws ec2 describe-instances --filters Name=instance-state-name,Values=running Name=tag:Type,Values=swarm-manager Name=tag:Role,Values=master Name=tag:Stack,Values=${STACK} | jq -r ".Reservations[].Instances[]")
       docker rm -f aws
       sleep 1
   done

   SWARM_MASTER_IP=$(echo ${SWARM_MASTER_NODE} | jq '."PrivateIpAddress"')
   SWARM_MASTER_IP=${SWARM_MASTER_IP#\"}
   SWARM_MASTER_IP=${SWARM_MASTER_IP%$suffix}
   SWARM_MASTER_IP=${SWARM_MASTER_IP/\"/}
   while [[ -z $SWARM_MASTER_TOKEN ]]; do
       echo 'Waiting for swarm master token ...'
       SWARM_MASTER_NODE=$(docker run -i --name aws -v /home/core/.aws:/root/.aws cgswong/aws:aws ec2 describe-instances --filters Name=instance-state-name,Values=running Name=tag:Type,Values=swarm-manager Name=tag:Role,Values=master Name=tag:Stack,Values=${STACK} | jq -r ".Reservations[].Instances[]")
       docker rm -f aws
       SWARM_MASTER_TOKEN=$(echo ${SWARM_MASTER_NODE} | jq '.Tags[] | select(.Key == "ManagerToken")'  | jq  -r ".Value" )
       sleep 1
   done
   docker swarm join --token ${SWARM_MASTER_TOKEN} ${SWARM_MASTER_IP}:2377
   SD_BOOT="-server -advertise ${PR_IPV4} -join ${SWARM_MASTER_IP}";
else
   while [[ -z $SWARM_MASTER_NODE ]]; do
       echo 'Waiting for swarm master run ...'
       SWARM_MASTER_NODE=$(docker run -i --name aws -v /home/core/.aws:/root/.aws cgswong/aws:aws ec2 describe-instances --filters Name=instance-state-name,Values=running Name=tag:Type,Values=swarm-manager Name=tag:Role,Values=master Name=tag:Stack,Values=${STACK} | jq -r ".Reservations[].Instances[]")
       docker rm -f aws
       sleep 1
   done
   SWARM_MASTER_IP=$(echo ${SWARM_MASTER_NODE} | jq '."PrivateIpAddress"')
   SWARM_MASTER_IP=${SWARM_MASTER_IP#\"}
   SWARM_MASTER_IP=${SWARM_MASTER_IP%$suffix}
   SWARM_MASTER_IP=${SWARM_MASTER_IP/\"/}
   while [[ -z $SWARM_WORKER_TOKEN ]]; do
       echo 'Waiting for swarm worker token run ...'
       SWARM_MASTER_NODE=$(docker run -i --name aws -v /home/core/.aws:/root/.aws cgswong/aws:aws ec2 describe-instances --filters Name=instance-state-name,Values=running Name=tag:Type,Values=swarm-manager Name=tag:Role,Values=master Name=tag:Stack,Values=${STACK} | jq -r ".Reservations[].Instances[]")
       docker rm -f aws
       SWARM_WORKER_TOKEN=$(echo ${SWARM_MASTER_NODE} | jq '.Tags[] | select(.Key == "WorkerToken")'  | jq  -r ".Value" )
       sleep 1
   done
   docker swarm join --token ${SWARM_WORKER_TOKEN} ${SWARM_MASTER_IP}:2377
   SD_BOOT="-advertise ${PR_IPV4} -join ${SWARM_MASTER_IP}";
fi

echo PR_IP="$PR_IPV4"                    >> /etc/docker/environments
echo STACK="$STACK"                      >> /etc/docker/environments
echo SERVICE_TYPE="$SERVICE_TYPE"        >> /etc/docker/environments
echo INSTANCE_ID="$INSTANCE_ID"          >> /etc/docker/environments
echo REGION="$REGION"                    >> /etc/docker/environments
echo PROVIDER="$PROVIDER"                >> /etc/docker/environments
echo SD_BOOT="$SD_BOOT"                  >> /etc/docker/environments
echo SWARM_MASTER_IP="$SWARM_MASTER_IP"  >> /etc/docker/environments

docker service create --mode global --name registrator --mount type=bind,source=/var/run/docker.sock,target=/tmp/docker.sock gliderlabs/registrator:latest --internal consul://${SWARM_MASTER_IP}:8500
