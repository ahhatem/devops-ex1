#!/bin/bash

# exit when any command fails (return non-zero value)
set -e

cd Terraform
./Deploy.sh
sleep 20
cd ../Ansible
./Deploy.sh