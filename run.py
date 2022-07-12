"""Excutes all steps for a multi-environment provisioning with Terraform.
"""

import sys


TFVARS = {
    'dev': {
        'subscription_id': '41f5ab0c-7fb5-4144-82ab-31491b47a479',
        'tenant_id': 'ddd290f8-76db-4ddd-b7e8-f57592ba9680'
    },
    'qa': {
        'subscription_id': '',
        'tenant_id': ''
    },
    'prod': {
        'subscription_id': '',
        'tenant_id': ''
    }
}


def create_backend(deployment_env):
    backend_template = open('./azure/_backend.tf.template').read()

    backend = backend_template.format(**{
        'deployment_env': deployment_env,
        'subscription_id': TFVARS[deployment_env]['subscription_id'],
        'tenant_id': TFVARS[deployment_env]['tenant_id']
    })

    with open('./azure/_backend.tf', 'w') as output_file:
        output_file.write(backend)


if __name__ == '__main__':
    args = sys.argv[1 : ]

    deployment_env = args[0]
    create_backend(deployment_env)
