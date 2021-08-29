#!/bin/bash

# exit when any command fails (return non-zero value)
set -e

cd "$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd Terraform
./Deploy.sh
sleep 20
cd ../Ansible
./Deploy.sh