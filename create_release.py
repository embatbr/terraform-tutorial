"""Executes all steps for a multi-environment provisioning with Terraform.
"""

import os
import shutil
import sys


SRC_DIRPATH = os.environ.get('SRC_DIRPATH')
RELEASE_DIRPATH = os.environ.get('RELEASE_DIRPATH')

TFVARS = {
    'dev': {
        'subscription_id': '41f5ab0c-7fb5-4144-82ab-31491b47a479',
        'tenant_id': 'ddd290f8-76db-4ddd-b7e8-f57592ba9680',
        'prevent_destroy': 'false'
    },
    'qa': {
        'subscription_id': '41f5ab0c-7fb5-4144-82ab-31491b47a479',
        'tenant_id': 'ddd290f8-76db-4ddd-b7e8-f57592ba9680',
        'prevent_destroy': 'false'
    },
    'prod': {
        'subscription_id': '41f5ab0c-7fb5-4144-82ab-31491b47a479',
        'tenant_id': 'ddd290f8-76db-4ddd-b7e8-f57592ba9680',
        'prevent_destroy': 'true'
    }
}


def replace_like_jinja(string, key, replacement):
    key_regex = "{{ %s }}" % key

    if replacement is None:
        return string.replace(key_regex, '')
    else:
        return string.replace(key_regex, replacement)


def replace_like_jinja_list(string, keys, replacements):
    new_string = string

    for (key, replacement) in zip(keys, replacements):
        new_string = replace_like_jinja(new_string, key, replacement)

    return new_string


def create_release(deployment_env):
    files = os.listdir(SRC_DIRPATH)

    if os.path.exists(RELEASE_DIRPATH) and os.path.isdir(RELEASE_DIRPATH):
        shutil.rmtree(RELEASE_DIRPATH)
    os.makedirs(RELEASE_DIRPATH, exist_ok=True)

    keys = list(TFVARS[deployment_env].keys())
    keys.insert(0, 'deployment_env')
    replacements = list(TFVARS[deployment_env].values())
    replacements.insert(0, deployment_env)

    for file in files:
        input_path = '{}/{}'.format(SRC_DIRPATH, file)
        output_path = '{}/{}'.format(RELEASE_DIRPATH, file)

        src_content = open(input_path).read()
        release_content = replace_like_jinja_list(src_content, keys, replacements)

        with open(output_path, 'w') as output_file:
            output_file.write(release_content)


if __name__ == '__main__':
    args = sys.argv[1 : ]

    deployment_env = args[0]
    create_release(deployment_env)
