#!/usr/bin/env bash

stackname="$1"
region="$2"

echo "Updating WebAppsStack (nested from $stackname)"

WebAppsStack="$(aws cloudformation describe-stacks --stack-name $stackname --region $region --output text --query 'Stacks[0].Outputs[?OutputKey==`WebAppsStack`].OutputValue')"
AppName=$stackname
KeyName="$(aws cloudformation describe-stacks --stack-name $stackname --region $region --output text --query 'Stacks[0].Outputs[?OutputKey==`KeyName`].OutputValue')"
VpcId="$(aws cloudformation describe-stacks --stack-name $stackname --region $region --output text --query 'Stacks[0].Outputs[?OutputKey==`VpcId`].OutputValue')"
PublicSubnetA="$(aws cloudformation describe-stacks --stack-name --region $region $stackname --output text --query 'Stacks[0].Outputs[?OutputKey==`PublicSubnetA`].OutputValue')"

aws cloudformation update-stack \
    --stack-name $WebAppsStack \
    --region $region \
    --capabilities CAPABILITY_IAM \
    --template-body file://cloudformation/aws-webapps-summitsp.template \
    --parameters ParameterKey=AppName,ParameterValue=$AppName \
        ParameterKey=KeyName,ParameterValue=$KeyName \
        ParameterKey=VpcId,ParameterValue=$VpcId \
        ParameterKey=PublicSubnetA,ParameterValue=$PublicSubnetA

stack_status="$(bash cfn-wait-for-stack.sh $stackname)"
if [ $? -ne 0 ]; then
    echo "Fatal: $(basename $0) stack $stackname ($stack_status) failed to update properly" >&2
    exit 1
fi

echo "$stackname was updated."