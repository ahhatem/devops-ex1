resource "tls_private_key" "Dell_SAS_Key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "null_resource" "null"{
    provisioner "local-exec" {
        command = "echo > hosts.ini"
    }
}

resource "aws_key_pair" "Dell_SAS_AWSKey" {
  key_name   = var.key_name
  public_key = tls_private_key.Dell_SAS_Key.public_key_openssh

  provisioner "local-exec" { # Create "myKey.pem" to your computer!!
    command = "echo '${tls_private_key.Dell_SAS_Key.private_key_pem}' > ./Dell_SAS_Key.pem; chmod 400 Dell_SAS_Key.pem"
  }
}

resource "aws_instance" "Dell_SAS_SAM"{
    ami = var.AMIS[var.AWS_REGION]
    instance_type= "t2.small"
    key_name = aws_key_pair.Dell_SAS_AWSKey.key_name
    tags={
        Name="Dell_SAS_SAM"
        env="Dell_SAS"
    }

    provisioner "local-exec" {
        command = "echo -e '[SAM]\n${aws_instance.Dell_SAS_SAM.public_ip}\n' >> hosts.ini"
    }
}

resource "aws_instance" "Dell_SAS_IP"{
    ami = var.AMIS[var.AWS_REGION]
    instance_type= "t2.small"
    key_name = aws_key_pair.Dell_SAS_AWSKey.key_name
    tags={
        Name="Dell_SAS_IP"
        env="Dell_SAS"
    }

    provisioner "local-exec" {
        command = "echo -e '[IP]\n${aws_instance.Dell_SAS_IP.public_ip}\n' >> hosts.ini"
    }
}