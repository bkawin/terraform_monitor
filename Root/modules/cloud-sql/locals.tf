locals {
  group_name = "${google_monitoring_group.sqlGroups.name}"
  group_id = split("/",local.group_name)[3]
  
  Alerts_config = [
    {
      display_name = "alert_policy_cpu_utilization"
      metric.type = "\"cloudsql.googleapis.com/database/cpu/utilization\"
      doc_content = "CPU Utilization is above 85% on VM."
    }
  ]
}




