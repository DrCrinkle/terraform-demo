data "aws_ami" "amazonlinux" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"]
}

resource "aws_efs_file_system" "foo" {

  tags = {
    Name = "Taylor EFS"
  }
}

resource "aws_efs_mount_target" "alpha" {
  count           = length(var.subnets)
  file_system_id  = aws_efs_file_system.foo.id
  subnet_id       = var.subnets[count.index]
  security_groups = var.security_group
}

resource "aws_efs_access_point" "test" {
  file_system_id = aws_efs_file_system.foo.id
}

resource "aws_instance" "efs_loader" {
  ami                    = data.aws_ami.amazonlinux.id
  instance_type          = "t2.micro"
  iam_instance_profile   = "s3-efs-full-access"
  user_data              = templatefile("./modules/efs/load_efs.tftpl", { efs_name = aws_efs_file_system.foo.dns_name })
  subnet_id              = var.subnets[1]
  vpc_security_group_ids = var.security_group

  depends_on = [
    aws_efs_mount_target.alpha
  ]

  tags = {
    Name = "EFS Loader"
  }
}
