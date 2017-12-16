#!/bin/bash

# This creates a reg secret for kubernetes in order to pull images.
# Use an existing DockerHub login...
# Args - $1 - username
# Args - $2 - password for username
# Args - $3 - email for username

export DOCKER_USERNAME=$1
export DOCKER_PASSWORD=$2
export DOCKER_EMAIL=$3

kubectl create secret \
    docker-registry \
    registrykey \
    --docker-server=https://index.docker.io/v1/ \
    --docker-username=${DOCKER_USERNAME} \
    --docker-password=${DOCKER_PASSWORD} \
    --docker-email=${DOCKER_EMAIL}


