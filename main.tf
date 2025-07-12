provider "aws" {
  region = "us-east-1"
}

variable "whitelisted_ips" {
  description = "List of IPs allowed to access frontend (SSH, HTTPS)"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

resource "aws_vpc" "securepay" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name        = "securepay"
    Environment = "prod"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.securepay.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"
  tags = {
    Name = "securepay-public"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.securepay.id
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.securepay.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

# Security Groups
resource "aws_security_group" "frontend_sg" {
  name        = "frontend-sg"
  description = "Allow HTTPS and SSH from whitelisted IPs"
  vpc_id      = aws_vpc.securepay.id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.whitelisted_ips
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.whitelisted_ips
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.whitelisted_ips
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "backend_sg" {
  name        = "backend-sg"
  description = "Allow traffic from frontend only"
  vpc_id      = aws_vpc.securepay.id

  ingress {
    from_port       = 3000
    to_port         = 3000
    protocol        = "tcp"
    security_groups = [aws_security_group.frontend_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "db_sg" {
  name        = "db-sg"
  description = "Allow traffic from backend only"
  vpc_id      = aws_vpc.securepay.id

  ingress {
    from_port       = 27017
    to_port         = 27017
    protocol        = "tcp"
    security_groups = [aws_security_group.backend_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Key Pair - using existing local key file
resource "aws_key_pair" "lab_key" {
  key_name   = "lab"
  public_key = file("${path.module}/lab.pub")
}

# AMI Lookup for Ubuntu 22.04
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

# EC2 Instances
resource "aws_instance" "frontend" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t3.small"
  subnet_id                   = aws_subnet.public_subnet.id
  vpc_security_group_ids      = [aws_security_group.frontend_sg.id]
  key_name                    = "lab"
  associate_public_ip_address = true

  root_block_device {
    encrypted = true
  }

  tags = {
    Name        = "frontend"
    Environment = "prod"
  }
}

resource "aws_instance" "backend" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t3.small"
  subnet_id                   = aws_subnet.public_subnet.id
  vpc_security_group_ids      = [aws_security_group.backend_sg.id]
  key_name                    = "lab"
  associate_public_ip_address = true

  root_block_device {
    encrypted = true
  }

  tags = {
    Name        = "backend"
    Environment = "prod"
  }
}

resource "aws_instance" "database" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t3.small"
  subnet_id                   = aws_subnet.public_subnet.id
  vpc_security_group_ids      = [aws_security_group.db_sg.id]
  key_name                    = "lab"
  associate_public_ip_address = true

  root_block_device {
    encrypted = true
  }

  tags = {
    Name        = "database"
    Environment = "prod"
  }
}

output "frontend_public_ip" {
  value = aws_instance.frontend.public_ip
}

output "backend_public_ip" {
  value = aws_instance.backend.public_ip
}

output "database_public_ip" {
  value = aws_instance.database.public_ip
}
