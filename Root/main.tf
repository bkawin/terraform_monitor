#module "vm" {
  source    = "./modules/compute-engine"
  threshold = var.vmthreshold
  alignment = var.vmalignment
  frequency = var.vmfrequency
  compare   = var.vmcompare
  group     = var.vmgroup
  channel   = var.vmchannel
  email     = var.vmemail
}


module "sql" {
  source    = "./modules/cloud-sql"
  threshold = var.sqlthreshold
  alignment = var.sqlalignment
  frequency = var.sqlfrequency
  compare   = var.sqlcompare
  group     = var.sqlgroup
  channel   = var.sqlchannel
  email     = var.sqlemail
  gcp_project = var.gcp_project
  dbname = var.dbname
}





