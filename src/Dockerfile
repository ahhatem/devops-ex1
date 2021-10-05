FROM centos
RUN yum install -y yum-utils vim
RUN yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
RUN yum -y install terraform
RUN yum -y install epel-release
RUN yum -y install ansible
RUN yum -y install openssh openssh-clients
RUN echo 'export PATH=$PATH:/usr/bin/' >> ~/.bashrc
WORKDIR /src
RUN cp Ansible /src
RUN cp Terraform /src
RUN cp Deploy.sh /src
RUN cp Destroy.sh /src