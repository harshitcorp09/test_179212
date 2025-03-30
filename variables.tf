variable "target_group_configs" {
  description = "Map of target groups with their configurations and target IPs"
  type = map(object({
    port                = number
    health_check_path   = string
    matcher            = string
    healthy_threshold  = number
    interval           = number
    timeout            = number
    unhealthy_threshold = number
    target_ips         = list(string)
  }))
}

variable "target_vpc_id" {
  description = "The VPC ID where the target group is created"
  type        = string
}

variable "stickiness" {
  description = "Enable or disable stickiness"
  type        = bool
  default     = false
}
