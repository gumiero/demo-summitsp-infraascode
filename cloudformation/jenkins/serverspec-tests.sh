#!/bin/bash

stackname="$1"
region="$2"

WebAppsStack="$(aws cloudformation describe-stacks --stack-name $stackname --region $region --output text --query 'Stacks[0].Outputs[?OutputKey==`WebAppsStack`].OutputValue')"

pushd serverspec
export webapp_security_group="$(aws cloudformation describe-stack-resources --stack-name $WebAppsStack --region $region --query StackResources[?LogicalResourceId==\`WebAppSG\`].PhysicalResourceId --output text)"
export webapp_region=$region
rspec
popd
