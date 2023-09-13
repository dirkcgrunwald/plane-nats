#!/bin/sh

if [ -z $TOKEN ];
then
    echo You need to define TOKEN
    exit 100
fi

export SERVER=$(hostname)

docker kill nats-main
docker rm nats-main

docker run --rm -d --name nats-main --network host \
       -v /home/ubuntu/nats:/home/ubuntu/nats \
       -v ./config-cluster.json:/etc/nats/nats-server.conf \
       -e TOKEN=$TOKEN -e SERVER=$SERVER \
       -p 4222:4222 -p 6222:6222 -p 8222:8222 -p 8080:8080 \
       nats -c /etc/nats/nats-server.conf 

