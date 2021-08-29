FROM centos
RUN yum install -y yum-utils vim
RUN yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
RUN yum -y install terraform
RUN yum -y install epel-release
RUN yum -y install ansible
RUN yum -y install openssh openssh-clients
RUN echo 'export PATH=$PATH:/usr/bin/' >> ~/.bashrc
WORKDIR '/Config/Terraform'
COPY Terraform/Modules.tf .
COPY Terraform/awsCredentials.auto.tfvars .
RUN terraform init
COPY Terraform/* .
RUN terraform init
WORKDIR '/Config/Ansible'
COPY Ansible/* .
WORKDIR '/Config'
COPY ./*.sh .
RUN chmod 700 Deploy.sh
RUN chmod 700 Destroy.sh
CMD "./Deploy.sh"