
variable "availability_zones" {
  description = "AZs in this region to use"
  default = ["us-east-1a", "us-east-1b"]
  type = list
}

variable "vpc_cidr" {
  default = "10.1.0.0/16"
}

variable "subnet_cidrs_public" {
  description = "Subnet CIDRs for public subnets (length must match configured availability_zones)"
  default = ["10.1.1.0/24", "10.1.2.0/24"]
  type = list
}
variable "tags" {
    type=object({
        Owner=string
        expiration_date=string
        bootcamp=string
    })
    default={
        Owner="nobel"
        expiration_date="01-29-2022"
        bootcamp="ghana1"
    }
}

variable "ingress_rules" {
    type = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_block  = string
      description = string
    }))
    default     = [
        {
          from_port   = 22
          to_port     = 22
          protocol    = "tcp"
          cidr_block  = "10.1.0.0/16"
          description = "test"
        },
        {
          from_port   = 80
          to_port     = 80
          protocol    = "tcp"
          cidr_block  = "10.1.0.0/16"
          description = "test"
        },
    ]
}
 
variable "webservers_ami" {
  default = "ami-0574da719dca65348"
}

variable "instance_type" {
  default = "t2.micro"
}