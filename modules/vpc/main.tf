# VPC
resource "aws_vpc" "abi-lu" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "abi-lu"
  }
}

# Subnets
resource "aws_subnet" "public-lu1" {
  vpc_id                 = aws_vpc.abi-lu.id
  cidr_block             = var.public_subnet_cidr_a
  map_public_ip_on_launch = true
  availability_zone      = var.availability_zone

  tags = {
    Name = "public-lu1"
  }
}

resource "aws_subnet" "public-lu2" {
  vpc_id                 = aws_vpc.abi-lu.id
  cidr_block             = var.public_subnet_cidr_b
  map_public_ip_on_launch = true
  availability_zone      = var.availability_zone2

  tags = {
    Name = "public-lu2"
  }
}

resource "aws_subnet" "private-lu1" {
  vpc_id            = aws_vpc.abi-lu.id
  cidr_block        = var.private_subnet_cidr
  availability_zone = var.availability_zone

  tags = {
    Name = "private-lu1"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.abi-lu.id

  tags = {
    Name = "abi-lu-igw"
  }
}

# Route Table for Public Subnets
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.abi-lu.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-route-table"
  }
}

# Associate Route Table with Public Subnets
resource "aws_route_table_association" "public-a" {
  subnet_id      = aws_subnet.public-lu1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public-b" {
  subnet_id      = aws_subnet.public-lu2.id
  route_table_id = aws_route_table.public.id
}

# Route Table for Private Subnets
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.abi-lu.id

  tags = {
    Name = "private-route-table"
  }
}

# Associate Route Table with Private Subnet
resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private-lu1.id
  route_table_id = aws_route_table.private.id
}


#Security-Group

resource "aws_security_group" "wordpress_sg" {
  name        = "wordpress-sg"
  description = "Allow HTTP, HTTPS, MySQL, and SSH traffic"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}





resource "aws_security_group" "lb_sg" {
  name        = "lb-sg"
  description = "Allow traffic for the Load Balancer"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }



  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }



  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "lb-sg"
  }
}





