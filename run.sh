#!/bin/bash


export CURRENT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd ${CURRENT_PATH}


COMMANDS_NOT_ALLOWED_IN_PROD=("apply destroy")

DEPLOYMENT_ENV="${1}"
COMMAND="${2}" # 'plan' or 'apply'

export SRC_DIRPATH="${CURRENT_PATH}/azure/src"
export RELEASE_DIRPATH="${CURRENT_PATH}/azure/releases/${DEPLOYMENT_ENV}"



python create_release.py "${DEPLOYMENT_ENV}"


cd ${RELEASE_DIRPATH}


TF_DIRPATH="${RELEASE_DIRPATH}/.terraform"

echo rm -Rf ${TF_DIRPATH}
rm -Rf ${TF_DIRPATH} # "removes" even when dir doesn't exist

echo terraform init
terraform init

if [[ ${DEPLOYMENT_ENV} == "prod" ]] && [[ " ${COMMANDS_NOT_ALLOWED_IN_PROD[*]} " =~ " ${COMMAND} " ]]
then
    echo "command '${COMMAND}' not allowed in '${DEPLOYMENT_ENV}'"
    echo "exiting"
    exit
else
    echo terraform fmt
    terraform fmt

    echo terraform ${COMMAND}
    terraform ${COMMAND}
fi
