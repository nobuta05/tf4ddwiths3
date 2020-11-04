terraform {
  required_version = "0.13.5"

  required_providers {
    datadog = {
      source = "datadog/datadog"
    }
  }

  backend "s3" {
    bucket = "tf-keishi-sandbox"
    region = "ap-northeast-1"
    profile = "default"
    key = "staging.tfstate"
  }
}

resource "datadog_monitor" "cpu_user_monitor_prod" {
  name = "CPU User Monitor for Production"
  type = "metric alert"
  message = "CPU user usage alert"
  query = "avg(last_5m):avg:system.cpu.user{*} by {host} > 80"

  tags = ["env:prod"]
}