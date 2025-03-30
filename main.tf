resource "aws_lb_target_group" "target_groups" {
  for_each = var.target_group_configs

  name        = each.key
  port        = each.value.port
  target_type = "ip"
  protocol    = "HTTPS"
  vpc_id      = var.target_vpc_id

  health_check {
    enabled             = true
    healthy_threshold   = each.value.healthy_threshold
    interval            = each.value.interval
    matcher             = each.value.matcher
    path                = each.value.health_check_path
    port                = "traffic-port"
    protocol            = "HTTPS"
    timeout             = each.value.timeout
    unhealthy_threshold = each.value.unhealthy_threshold
  }

  stickiness {
    cookie_duration = 86400
    cookie_name     = "tg_secure_cookie"
    enabled         = var.stickiness
    type            = "lb_cookie"
  }
}

resource "aws_lb_target_group_attachment" "tg_attachment" {
  for_each = {
    for tg_key, tg_value in var.target_group_configs :
    for ip in tg_value.target_ips :
      "${tg_key}-${ip}" => {
        target_group_key = tg_key
        target_ip        = ip
      }
  }

  target_group_arn = aws_lb_target_group.target_groups[each.value.target_group_key].arn
  target_id        = each.value.target_ip
  port            = var.target_group_configs[each.value.target_group_key].port
}
