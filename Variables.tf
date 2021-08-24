variable "AWS_REGION"{
    type=string
    default="eu-central-1"
}

variable "AMIS"{
    type=map(string)
    default={
        eu-central-1="ami-0453cb7b5f2b7fca2"
    }
}

variable "DEFULT_SG"{
    type=string
    default="sg-ba6a46d3"
}