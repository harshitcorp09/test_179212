target_group_configs = {
  "tg-https-app1" = {
    port                = 443
    health_check_path   = "/health"
    matcher            = "200"
    healthy_threshold  = 5
    interval           = 15
    timeout            = 3
    unhealthy_threshold = 2
    target_ips         = ["10.0.1.10", "10.0.1.11"]
  }

  "tg-https-app2" = {
    port                = 8443
    health_check_path   = "/status"
    matcher            = "302"
    healthy_threshold  = 3
    interval           = 20
    timeout            = 5
    unhealthy_threshold = 2
    target_ips         = ["10.0.1.20", "10.0.1.21"]
  }
}

target_vpc_id = "vpc-12345678"
stickiness    = false
