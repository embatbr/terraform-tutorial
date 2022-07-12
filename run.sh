#!/bin/bash


export CURRENT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd ${CURRENT_PATH}


DEPLOYMENT_ENV="${1}"
COMMAND="${2}" # 'plan' or 'apply'


python pre_run.py "${DEPLOYMENT_ENV}"
cd azure
if [[ ! -d ".terraform" ]] || [[ $(cat .terraform/deployment_env) != "${DEPLOYMENT_ENV}" ]]
then
    pwd
    rm -Rf .terraform # "removes" even when dir doesn't exist
    terraform init
    echo -n "${DEPLOYMENT_ENV}" > .terraform/deployment_env
fi
terraform ${COMMAND} -var="deployment_env=${DEPLOYMENT_ENV}"
