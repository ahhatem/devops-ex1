resource "aws_instance" "dell_SAS_SAM"{
    ami = var.AMIS[var.AWS_REGION]
    instance_type= "t2.small"
}