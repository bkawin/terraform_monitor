locals {
  group_name = "${google_monitoring_group.linuxGroups.name}"
  group_id = split("/",local.group_name)[3]
  metric = ["instance/cpu/utilization\"","disk/percent_used\"", "cpu/usage_time\"", "memory/bytes_used\"", "instance/memory/balloon/ram_used\"","disk/bytes_used\"","pagefile/percent_used\"","instance/uptime\""]
  api = ["\"compute.googleapis.com/","\"agent.googleapis.com/","\"agent.googleapis.com/","\"agent.googleapis.com/", "\"compute.googleapis.com/",    "\"agent.googleapis.com/", "\"agent.googleapis.com/", "\"compute.googleapis.com/"]
  
  #-----------Test------------------
  Alerts_config = [
    {
      display_name = "alert_policy_cpu_utilization"
      metric_type       = format("%s%s",local.api[0],local.metric[0])
      doc_content = "CPU Utilization is above 85% on VM."
    },
    {
      display_name = "alert_policy_disk_utilization"
      metric_type = format("%s%s",local.api[1],local.metric[1])
      doc_content = "Disk Utilization is above 85% on VM."
            
    },
    {
      display_name = "alert_policy_cpu_usage"
      metric_type       = format("%s%s",local.api[1],local.metric[2])
      doc_content = "cpu_usage time"
    },
    {
      display_name = "alert_policy_Memory Usage"
      metric_type = format("%s%s",local.api[1],local.metric[3])
      doc_content = "memory bytes used"
            
    },
    {
      display_name = "alert_policy_Memory_utilization"
      metric_type       = format("%s%s",local.api[0],local.metric[4])
      doc_content = "Memory Utilization is above 85% on VM."
    },
    {
      display_name = "alert_policy_VM_bytes_used"
      metric_type = format("%s%s",local.api[1],local.metric[5])
      doc_content = "Disk bytes used"
            
    },
    {
      display_name = "alert_policy_Pagefile utilization"
      metric_type       = format("%s%s",local.api[1],local.metric[6])
      doc_content = "Pagefile Utilization is above 85% on VM."
    },
    {
      display_name = "alert_policy_vm_uptime"
      metric_type = format("%s%s",local.api[0],local.metric[7])
      doc_content = "Uptime of VM."
            
    }
  ]
}




