#vpc nobel-vpc-1
resource "aws_vpc" "nobel_vpc_1" {
  cidr_block=var.vpc_cidr
  instance_tenancy="default"
  tags={
    Owner="nobel",
    expiration_date="01-29-2023",
    bootcamp="ghana1"
  }
} 


#Internet Gateway

resource "aws_internet_gateway" "nobel_igw" {
    vpc_id=aws_vpc.nobel_vpc_1.id
}


#two public subnets

resource "aws_subnet" "nobel_public_sn" {
  count = "${length(var.subnet_cidrs_public)}"

  vpc_id = "${aws_vpc.nobel_vpc_1.id}"
  cidr_block = element(var.subnet_cidrs_public,count.index)
  availability_zone = "${var.availability_zones[count.index]}"
  map_public_ip_on_launch = true
    tags = {
    Name = "Subnet-${count.index+1}"
  }
}

#Route table
resource "aws_route_table" "nobel_PublicRt_1" {
    vpc_id = "${aws_vpc.nobel_vpc_1.id}"
    route {
        cidr_block="0.0.0.0/0"
        gateway_id= aws_internet_gateway.nobel_igw.id
    }
    tags={
    Owner="nobel",
    expiration_date="01-29-2023",
    bootcamp="ghana1"
  }

} 

resource "aws_route_table_association" "nobel_PublicRt_assoc" {
  count = "${length(var.subnet_cidrs_public)}"

  subnet_id = "${element(aws_subnet.nobel_public_sn.*.id, count.index)}"
  route_table_id = "${aws_route_table.nobel_PublicRt_1.id}"
}
 
