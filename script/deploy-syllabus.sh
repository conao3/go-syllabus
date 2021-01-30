#!/bin/bash

set -eux

ENV=${1:-dev}
TEMPLATE=template.yaml
PROJECT=$(cat .env | grep Project= | cut -f2 -d=)
STACK_NAME=$ENV-$PROJECT

AWS="aws --profile $ENV"
SAM_OPTIONS="--profile $ENV"
S3_BUCKET=$(cat .env | grep S3Bucket= | cut -f2 -d=)
S3_PREFIX=$(cat .env | grep S3Prefix= | cut -f2 -d=)

sam validate --template-file $TEMPLATE
STATUS=$($AWS cloudformation describe-stacks --stack-name $STACK_NAME --query 'Stacks[].StackStatus[]' --output text) || true

case "$STATUS" in
    'CREATE_IN_PROGRESS') $AWS cloudformation wait stack-create-complete --stack-name $STACK_NAME ;;
    'UPDATE_IN_PROGRESS') $AWS cloudformation wait stack-update-complete --stack-name $STACK_NAME ;;
    'DELETE_IN_PROGRESS') $AWS cloudformation wait stack-delete-complete --stack-name $STACK_NAME ;;
    'ROLLBACK_COMPLETE')
        $AWS cloudformation delete-stack --stack-name $STACK_NAME
        $AWS cloudformation wait stack-delete-complete --stack-name $STACK_NAME ;;
esac

sam deploy $SAM_OPTIONS \
    --template-file $TEMPLATE \
    --stack-name $STACK_NAME \
    --s3-bucket $S3_BUCKET \
    --s3-prefix $S3_PREFIX \
    --capabilities CAPABILITY_NAMED_IAM \
    --no-fail-on-empty-changeset \
    --parameter-overrides $(cat .env | tr '\n' ' ') \
    --tags Project=$PROJECT || true
