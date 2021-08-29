resource "tls_private_key" "Dell_DemoApp_Key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "null_resource" "null"{
    provisioner "local-exec" {
        command = "echo > hosts.ini"
    }
}

resource "aws_key_pair" "Dell_DemoApp_AWSKey" {
  key_name   = var.key_name
  public_key = tls_private_key.Dell_DemoApp_Key.public_key_openssh

  provisioner "local-exec" { # Create "myKey.pem" to your computer!!
    command = "echo '${tls_private_key.Dell_DemoApp_Key.private_key_pem}' > ./Dell_DemoApp_Key.pem; chmod 400 Dell_DemoApp_Key.pem"
  }
}

resource "aws_db_instance" "Dell_DemoApp_DB" {
  allocated_storage        = 20 # gigabytes
#   backup_retention_period  = 7   # in days
  engine                   = "postgres"
  identifier               = "dell-demodpp-db"
  instance_class           = "db.t3.micro"
  multi_az                 = false
  name                     = "Dell_DemoApp_DB"
  password                 = "Dell_DemoApp_DB_pass"
  port                     = 5432
  publicly_accessible      = true
  storage_encrypted        = false # you should always do this
  storage_type             = "gp2"
  username                 = "Dell_DemoApp_DB_user"
  skip_final_snapshot      = true
}


resource "aws_instance" "Dell_DemoApp_Web"{
    ami = var.AMIS[var.AWS_REGION]
    instance_type= "t2.small"
    key_name = aws_key_pair.Dell_DemoApp_AWSKey.key_name
    tags={
        Name="Dell_DemoApp_Web"
        env="Dell_DemoAPP"
    }

    provisioner "local-exec" {
        command = "echo -e '[Web]\n${aws_instance.Dell_DemoApp_Web.public_ip}\tAPI=${aws_instance.Dell_DemoApp_API.public_ip}\n' >> hosts.ini"
    }
}

resource "aws_instance" "Dell_DemoApp_API"{
    ami = var.AMIS[var.AWS_REGION]
    instance_type= "t2.small"
    key_name = aws_key_pair.Dell_DemoApp_AWSKey.key_name
    tags={
        Name="Dell_DemoApp_API"
        env="Dell_DemoAPP"
    }

    provisioner "local-exec" {
        command = "echo -e '[API]\n${aws_instance.Dell_DemoApp_API.public_ip}\tdb=${aws_db_instance.Dell_DemoApp_DB.endpoint}\tdbusername=${aws_db_instance.Dell_DemoApp_DB.username}\tdbpass=${aws_db_instance.Dell_DemoApp_DB.password}\tdbname=${aws_db_instance.Dell_DemoApp_DB.name}\n' >> hosts.ini"
    }
}