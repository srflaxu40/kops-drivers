#!/bin/bash

# $1 - hosted zone ID
# $2 - profile (from ~/.aws/credentials typically)

aws route53 change-resource-record-sets \
 --hosted-zone-id $1 \
 --change-batch file://subdomain.json \
 --profile $2
