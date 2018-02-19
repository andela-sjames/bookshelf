#!/usr/bin/env bash

# reference: https://docs.aws.amazon.com/AmazonECR/latest/userguide/ECR_GetStarted.html
# video: https://aws.amazon.com/ecr/getting-started/

# script used to deploy to ECR 
# login to ECR
echo 'logging into ECR'
aws configure set default.region us-east-1
aws configure set default.output json
token=$(aws ecr get-authorization-token)
registry=$(echo "$token" | jq -r .authorizationData[].proxyEndpoint | sed -e 's|https://||g')
pass=$(echo "$token" | jq -r .authorizationData[].authorizationToken | base64 -D | cut -d: -f2)
echo "$pass" | docker login -u AWS --password-stdin "$registry" 

echo 'aws auth successful'

image=768614346553.dkr.ecr.us-east-1.amazonaws.com/bookshelfapp_ecr:latest

echo 'build and deploy image'
docker build -t bookshelfapp_ecr .
docker tag bookshelfapp_ecr:latest $image
docker push $image
echo 'docker image successfully pushed to ECR!'

# ignore
# upload task definition.
#  aws ecs register-task-definition --cli-input-json file://bkshelf-task-def.json
#  aws ecs run-task --task-definition sample-ecr-bookshelf
