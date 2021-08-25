#!/bin/bash

# exit when any command fails (return non-zero value)
set -e

terraform apply -auto-approve
sleep 20
ansible-playbook -i hosts.ini --private-key Dell_SAS_Key.pem -u ec2-user DeploySmarts.yml