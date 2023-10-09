#provider "aws"{
#region="us-west-2"
#}
#resource "aws_instance" "rhel-instance" {
#  ami           = "ami-00aa0673b34e3c150"     # Replace with the RHEL AMI ID for your region
#  instance_type = "t2.micro"         # Choose the desired instance type
#  key_name      = "rhel-instance-tf"    # Replace with your SSH key pair name
#
#  tags = {
#    Name = "RHEL Instance TF"
#  }
#}

# Optional: Define security group, key pair, or other resources as needed.
#--------------------------------------------------------------------------
provider "aws" {
  region = "us-west-2"
}

# Define a security group
resource "aws_security_group" "rhel_SG" {
  name        = "rhel-security-group"
  description = "Rhel security group"
  vpc_id      = "vpc-0c55f092c96df9238" # Replace with your VPC ID

  # Define inbound and outbound rules here
  # Example: allow SSH and HTTP traffic
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["172.16.0.0/16"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Define a subnet
resource "aws_subnet" "subnet" {
  vpc_id                  = "vpc-0c55f092c96df9238" # Replace with your VPC ID
  cidr_block              = "172.16.0.0/24" # Replace with your desired subnet CIDR
  availability_zone       = "us-west-2a"  # Replace with your desired AZ
  map_public_ip_on_launch = true
}

# Define an EC2 instance with an EBS volume
resource "aws_instance" "rhel_instance" {
  ami           = "ami-00aa0673b34e3c150"
  instance_type = "t2.micro"
  key_name      = "rhel-instance-tf"
  subnet_id     = "subnet-023fc8b52173ea9eb"
  #security_groups = "sg-0ae4830a71404ba09"

  # Optional: Define additional EBS volume
  root_block_device {
    volume_size = 50
    volume_type = "gp2"
  }

  tags = {
    Name = "RHEL Instance"
  }
}
