#!/bin/bash
docker pull cgswong/aws:aws

PROVIDER="AWS"
INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
PUBLIC_IPV4=$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)
PR_IPV4=$(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)
HOST=$(curl -s http://169.254.169.254/latest/meta-data/public-hostname)
REGION=$(curl -s http://169.254.169.254/latest/dynamic/instance-identity/document | jq -r ".region")

EXIST_NODE=$(docker run -i --rm --name aws -v /home/core/.aws:/root/.aws cgswong/aws:aws ec2 describe-instances --filters Name=instance-id,Values=${INSTANCE_ID} | jq -r ".Reservations[].Instances[]")
STACK=$(echo ${EXIST_NODE} | jq '.Tags[] | select(.Key == "Stack")'  | jq  -r ".Value" )
SERVICE_TYPE=$(echo ${EXIST_NODE} | jq '.Tags[] | select(.Key == "Type")'  | jq  -r ".Value" )
ROLE=$(echo ${EXIST_NODE} | jq '.Tags[] | select(.Key == "Role")'  | jq  -r ".Value" )
ENV=$(echo ${EXIST_NODE} | jq '.Tags[] | select(.Key == "Env")'  | jq  -r ".Value" )

while [[ -z $VAULT_SERVER ]]; do
   echo 'Waiting for swarm master run ...'
   VAULT_SERVER=$(docker run -i --rm --name aws -v /home/core/.aws:/root/.aws cgswong/aws:aws ec2 describe-instances --filters Name=instance-state-name,Values=running Name=tag:Type,Values=ca-server Name=tag:Role,Values=master Name=tag:Stack,Values=${STACK} | jq -r ".Reservations[].Instances[]")
   sleep 1
done

while [[ -z $VAULT_TOKEN ]]; do
   echo 'Waiting for vault token ...'
   VAULT_SERVER=$(docker run -i --rm --name aws -v /home/core/.aws:/root/.aws cgswong/aws:aws ec2 describe-instances --filters Name=instance-state-name,Values=running Name=tag:Type,Values=ca-server Name=tag:Role,Values=master Name=tag:Stack,Values=${STACK} | jq -r ".Reservations[].Instances[]")
   VAULT_TOKEN=$(echo ${VAULT_SERVER} | jq '.Tags[] | select(.Key == "VaultToken")'  | jq  -r ".Value" )
   sleep 1
done

VAULT_SERVER_IP=$(echo ${VAULT_SERVER} | jq '."PrivateIpAddress"')
VAULT_SERVER_IP=${VAULT_SERVER_IP#\"}
VAULT_SERVER_IP=${VAULT_SERVER_IP%$suffix}
VAULT_SERVER_IP=${VAULT_SERVER_IP/\"/}

if [ "$SERVICE_TYPE" == "swarm-manager" ] && [ "$ROLE" == "master" ]; then
   SWARM_MASTER_IP=${PR_IPV4}
   docker swarm init --advertise-addr ${PR_IPV4}
   docker run -i --rm --name aws -v /home/core/.aws:/root/.aws cgswong/aws:aws ec2 create-tags --resources ${INSTANCE_ID} --tags Key=ManagerToken,Value=$(docker swarm join-token -q manager)
   docker run -i --rm --name aws -v /home/core/.aws:/root/.aws cgswong/aws:aws ec2 create-tags --resources ${INSTANCE_ID} --tags Key=WorkerToken,Value=$(docker swarm join-token -q worker)
   SD_BOOT="-server -advertise ${PR_IPV4} -advertise-wan ${PUBLIC_IPV4} -bootstrap"

elif [ "$SERVICE_TYPE" == "swarm-manager" ] && [ "$ROLE" == "slave" ]; then
   while [[ -z $SWARM_MASTER_NODE ]]; do
       echo 'Waiting for swarm master run ...'
       SWARM_MASTER_NODE=$(docker run -i --rm --name aws -v /home/core/.aws:/root/.aws cgswong/aws:aws ec2 describe-instances --filters Name=instance-state-name,Values=running Name=tag:Type,Values=swarm-manager Name=tag:Role,Values=master Name=tag:Stack,Values=${STACK} | jq -r ".Reservations[].Instances[]")
       sleep 1
   done

   SWARM_MASTER_IP=$(echo ${SWARM_MASTER_NODE} | jq '."PrivateIpAddress"')
   SWARM_MASTER_IP=${SWARM_MASTER_IP#\"}
   SWARM_MASTER_IP=${SWARM_MASTER_IP%$suffix}
   SWARM_MASTER_IP=${SWARM_MASTER_IP/\"/}
   while [[ -z $SWARM_MASTER_TOKEN ]]; do
       echo 'Waiting for swarm master token ...'
       SWARM_MASTER_NODE=$(docker run -i --rm --name aws -v /home/core/.aws:/root/.aws cgswong/aws:aws ec2 describe-instances --filters Name=instance-state-name,Values=running Name=tag:Type,Values=swarm-manager Name=tag:Role,Values=master Name=tag:Stack,Values=${STACK} | jq -r ".Reservations[].Instances[]")
       SWARM_MASTER_TOKEN=$(echo ${SWARM_MASTER_NODE} | jq '.Tags[] | select(.Key == "ManagerToken")'  | jq  -r ".Value" )
       sleep 1
   done
   docker swarm join --token ${SWARM_MASTER_TOKEN} ${SWARM_MASTER_IP}:2377
   SD_BOOT="-server -advertise ${PR_IPV4} -advertise-wan ${PUBLIC_IPV4} -join ${SWARM_MASTER_IP}";
else
   while [[ -z $SWARM_MASTER_NODE ]]; do
       echo 'Waiting for swarm master run ...'
       SWARM_MASTER_NODE=$(docker run -i --rm --name aws -v /home/core/.aws:/root/.aws cgswong/aws:aws ec2 describe-instances --filters Name=instance-state-name,Values=running Name=tag:Type,Values=swarm-manager Name=tag:Role,Values=master Name=tag:Stack,Values=${STACK} | jq -r ".Reservations[].Instances[]")
       sleep 1
   done
   SWARM_MASTER_IP=$(echo ${SWARM_MASTER_NODE} | jq '."PrivateIpAddress"')
   SWARM_MASTER_IP=${SWARM_MASTER_IP#\"}
   SWARM_MASTER_IP=${SWARM_MASTER_IP%$suffix}
   SWARM_MASTER_IP=${SWARM_MASTER_IP/\"/}
   while [[ -z $SWARM_WORKER_TOKEN ]]; do
       echo 'Waiting for swarm worker token run ...'
       SWARM_MASTER_NODE=$(docker run -i --rm --name aws -v /home/core/.aws:/root/.aws cgswong/aws:aws ec2 describe-instances --filters Name=instance-state-name,Values=running Name=tag:Type,Values=swarm-manager Name=tag:Role,Values=master Name=tag:Stack,Values=${STACK} | jq -r ".Reservations[].Instances[]")
       SWARM_WORKER_TOKEN=$(echo ${SWARM_MASTER_NODE} | jq '.Tags[] | select(.Key == "WorkerToken")'  | jq  -r ".Value" )
       sleep 1
   done
   docker swarm join --token ${SWARM_WORKER_TOKEN} ${SWARM_MASTER_IP}:2377
   SD_BOOT="-advertise ${PR_IPV4} -advertise-wan ${PUBLIC_IPV4} -join ${SWARM_MASTER_IP}";
fi

echo PR_IP="'${PR_IPV4}'"                    >> /etc/docker/environments
echo STACK="'${STACK}'"                      >> /etc/docker/environments
echo SERVICE_TYPE="'${SERVICE_TYPE}'"        >> /etc/docker/environments
echo INSTANCE_ID="'${INSTANCE_ID}'"          >> /etc/docker/environments
echo REGION="'${REGION}'"                    >> /etc/docker/environments
echo PROVIDER="'${PROVIDER}'"                >> /etc/docker/environments
echo SD_BOOT="'${SD_BOOT}'"                  >> /etc/docker/environments
echo SWARM_MASTER_IP="'${SWARM_MASTER_IP}'"  >> /etc/docker/environments
echo VAULT_SERVER_IP="'${VAULT_SERVER_IP}'"  >> /etc/docker/environments
echo VAULT_TOKEN="'${VAULT_TOKEN}'"          >> /etc/docker/environments

docker pull registry.monapi.com:5000/monapi/fpm:monapi-5.6.30
docker pull registry.monapi.com:5000/monapi/alpine:3.4

# @todo prometheus storage volume
sudo mkdir -p /docker/prometheus/data
sudo mkdir -p /docker/prometheus/config
sudo wget  -O /docker/prometheus/config/prometheus.yml https://raw.githubusercontent.com/vfarcic/cloud-provisioning/master/conf/prometheus.yml

sudo cat << EOF > /tmp/${ENV}.json
{"domain": "${STACK}", "ip": "${SWARM_MASTER_IP}"}
EOF

sudo docker run -i --rm --name aws -v /tmp:/tmp -v /home/core/.aws:/root/.aws cgswong/aws:aws s3 cp /tmp/${ENV}.json s3://bucket.ci.monapi.com/${ENV}.json
#cd / && sudo curl -L git.io/scope -o /scope && sudo chmod a+x /scope && sudo chown core:core /scope  && ./scope launch --service-token=c84ffqfkjk37nj564dg6jxicd3egog85

