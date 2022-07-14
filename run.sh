#!/bin/bash


export CURRENT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd ${CURRENT_PATH}


COMMANDS_NOT_ALLOWED_IN_PROD=("apply destroy")

DEPLOYMENT_ENV="${1}"
COMMAND="${2}" # 'plan' or 'apply'


python pre_run.py "${DEPLOYMENT_ENV}"

cd azure

if [[ ! -d ".terraform" ]] || [[ $(cat .terraform/deployment_env) != "${DEPLOYMENT_ENV}" ]]
then
    echo rm -Rf .terraform
    rm -Rf .terraform # "removes" even when dir doesn't exist

    echo terraform init
    terraform init

    echo echo -n "${DEPLOYMENT_ENV}" > .terraform/deployment_env
    echo -n "${DEPLOYMENT_ENV}" > .terraform/deployment_env
fi

if [[ ${DEPLOYMENT_ENV} == "prod" ]] && [[ " ${COMMANDS_NOT_ALLOWED_IN_PROD[*]} " =~ " ${COMMAND} " ]]
then
    echo "command '${COMMAND}' not allowed in '${DEPLOYMENT_ENV}'"
    echo "exiting"
    exit
else
    echo terraform ${COMMAND} -var="deployment_env=${DEPLOYMENT_ENV}"
    terraform ${COMMAND} -var="deployment_env=${DEPLOYMENT_ENV}"
fi
