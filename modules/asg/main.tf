resource "aws_launch_template" "wordpress_lu" {
  name          = var.template_name
  image_id      = var.image_id
  instance_type = var.instance_type
    tags = {
    Name = "wordpress-lu"
  }
  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [var.wordpress_sg_id]

  }
}


resource "aws_autoscaling_group" "lu" {
  
    name = "lu"
  launch_template {
    id = aws_launch_template.wordpress_lu.id
    version = "$Latest"
  }

    
    
  
  vpc_zone_identifier = var.public_subnet_ids
  desired_capacity    = 1
  max_size            = 2
  min_size            = 1

  target_group_arns = [aws_lb_target_group.TG_lu.arn]
  tag {
    key                 = "Name"
    value               = "lu-wordpress"
    propagate_at_launch = true
  }

  



  
}


resource "aws_autoscaling_policy" "scale_up" {
  name                   = "scale_up"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.lu.name
  metric_aggregation_type = "Average"
}

resource "aws_autoscaling_policy" "scale_down" {
  name                   = "scale_down"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.lu.name
  metric_aggregation_type = "Average"
}







resource "aws_lb" "lb_lu" {
  name               = "lu-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.lb_security_group_id]

  subnet_mapping {
    subnet_id = var.public_subnet_ids[0]
  }

  subnet_mapping {
    subnet_id = var.public_subnet_ids[1]
  }
}

resource "aws_lb_target_group" "TG_lu" {
  name     = "wordpress-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    path                = "/"
    matcher             = "200"
  }
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.lb_lu.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.TG_lu.arn
  }
}


# Create a new ALB Target Group attachment
resource "aws_autoscaling_attachment" "TG_attachment" {
  autoscaling_group_name = aws_autoscaling_group.lu.id
  lb_target_group_arn    = aws_lb_target_group.TG_lu.arn
}

resource "aws_security_group_rule" "allow_lb_health_check" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = var.lb_security_group_id
  security_group_id        = var.wordpress_sg_id
}