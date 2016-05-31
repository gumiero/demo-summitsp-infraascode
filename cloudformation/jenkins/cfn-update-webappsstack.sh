#!/usr/bin/env bash
set -e

stackname="$1"
region="$2"


echo "Checking if WebAppsStack is valid"

aws cloudformation validate-template \
    --region $region \
    --template-body file://cloudformation/aws-webapps-summitsp.template

echo "Updating WebAppsStack"

WebAppsStack="$(aws cloudformation describe-stacks --stack-name $stackname --region $region --output text --query 'Stacks[0].Outputs[?OutputKey==`WebAppsStack`].OutputValue')"
AppName=$stackname
KeyName="$(aws cloudformation describe-stacks --stack-name $stackname --region $region --output text --query 'Stacks[0].Outputs[?OutputKey==`KeyName`].OutputValue')"
VpcId="$(aws cloudformation describe-stacks --stack-name $stackname --region $region --output text --query 'Stacks[0].Outputs[?OutputKey==`VpcId`].OutputValue')"
PublicSubnetA="$(aws cloudformation describe-stacks --stack-name --region $region $stackname --output text --query 'Stacks[0].Outputs[?OutputKey==`PublicSubnetA`].OutputValue')"

set +e
aws cloudformation update-stack \
    --stack-name $WebAppsStack \
    --region $region \
    --capabilities CAPABILITY_IAM \
    --template-body file://cloudformation/aws-webapps-summitsp.template \
    --parameters ParameterKey=AppName,ParameterValue=$AppName \
        ParameterKey=KeyName,ParameterValue=$KeyName \
        ParameterKey=VpcId,ParameterValue=$VpcId \
        ParameterKey=PublicSubnetA,ParameterValue=$PublicSubnetA
set -e

stack_status="$(bash cfn-wait-for-stack.sh $stackname)"
if [ $? -ne 0 ]; then
    echo "Fatal: $(basename $0) stack $stackname ($stack_status) failed to update properly" >&2
    exit 1
fi

echo "$stackname was updated."