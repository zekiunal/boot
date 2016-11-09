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

docker pull registry.monapi.com:5000/monapi/fpm:monapi-5.6.27
docker pull registry.monapi.com:5000/monapi/alpine:3.4
groupadd -r docker
usermod -a -G docker newrelic

docker network create --driver overlay proxy

# Log
############################################################################################################################################
docker network create --driver overlay syslog
docker service create --with-registry-auth --name="syslog" --mode global --reserve-memory 64m \
    --container-label com.monitoring.group=logging \
    --network syslog \
    -e SERVICE_514_NAME="syslog" -e SERVICE_514_TAGS="service" \
    -e CONSUL_ADDRESS=$(hostname --i) \
    registry.monapi.com:5000/monapi/syslog

docker service create --name node-exporter --mode global --network proxy --reserve-memory 64m \
--container-label com.monitoring.group=logging \
--mount "type=bind,source=/proc,target=/host/proc" \
--mount "type=bind,source=/sys,target=/host/sys" \
--mount "type=bind,source=/,target=/rootfs" \
--mount "type=bind,source=/etc/hostname,target=/etc/host_hostname" \
-e HOST_HOSTNAME=/etc/host_hostname \
basi/node-exporter:v0.1.1 \
-collector.procfs /host/proc \
-collector.sysfs /host/proc \
-collector.filesystem.ignored-mount-points "^/(sys|proc|dev|host|etc)($|/)" \
-collector.textfile.directory /etc/node-exporter/ \
-collectors.enabled="conntrack,diskstats,entropy,filefd,filesystem,loadavg,mdadm,meminfo,netdev,netstat,stat,textfile,time,vmstat,ipvs"

docker service create --name cadvisor --reserve-memory 64m \
--container-label com.monitoring.group=logging \
--mode global \
--network proxy \
--mount "type=bind,source=/,target=/rootfs" \
--mount "type=bind,source=/var/run,target=/var/run" \
--mount "type=bind,source=/sys,target=/sys" \
--mount "type=bind,source=/var/lib/docker,target=/var/lib/docker" \
google/cadvisor:v0.24.1

sudo mkdir -p /docker/prometheus/data
sudo mkdir -p /docker/prometheus/config
sudo wget  -O /docker/prometheus/config/prometheus.yml https://raw.githubusercontent.com/vfarcic/cloud-provisioning/master/conf/prometheus.yml

docker service create \
--container-label com.monitoring.group=logging \
--replicas 1 \
--constraint 'node.role == manager' --constraint 'engine.labels.role == master' \
--name prometheus \
--network proxy \
-p 9090:9090 \
--constraint 'node.role == manager' --constraint 'engine.labels.role == master' \
--mount "type=bind,source=/docker/prometheus/config/prometheus.yml,target=/etc/prometheus/prometheus.yml" \
--mount "type=bind,source=/docker/prometheus/data,target=/prometheus" \
prom/prometheus:v1.2.1

docker service create --reserve-memory 64m \
--container-label com.monitoring.group=logging \
--name grafana \
--network proxy \
-p 3000:3000 \
grafana/grafana:3.1.1

docker service create --with-registry-auth --name elasticsearch --network proxy --container-label com.monitoring.group=logging -p 9200:9200 --reserve-memory 500m  elasticsearch:2.4
docker service create --with-registry-auth --name logstash      --network proxy --container-label com.monitoring.group=logging -e LOGSPOUT=ignore --reserve-memory 500m  registry.monapi.com:5000/monapi/logstash:service2
docker service create --with-registry-auth --name logspout      --network proxy --container-label com.monitoring.group=logging --mode global --mount "type=bind,source=/var/run/docker.sock,target=/var/run/docker.sock" -e SYSLOG_FORMAT=rfc3164 gliderlabs/logspout syslog://logstash:51415
docker service create --with-registry-auth --name kibana        --network proxy -p 5601:5601 -e ELASTICSEARCH_URL=http://elasticsearch:9200 --container-label com.monitoring.group=logging --reserve-memory 450m kibana:4.6

