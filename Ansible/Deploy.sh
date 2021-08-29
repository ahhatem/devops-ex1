#!/bin/bash
ansible-playbook -i ../Terraform/hosts.ini --private-key ../Terraform/Dell_DemoApp_Key.pem -u ec2-user DeployApp.yml