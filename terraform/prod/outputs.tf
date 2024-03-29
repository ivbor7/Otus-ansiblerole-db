output "app_ext_ip" {
  value = "${module.app.app_ext_ip}"
}

output "db_int_ip" {
  value = "${module.db.db_int_ip}"
}

output "db_ext_ip" {
  value = "${module.db.db_ext_ip}"
}

output "dyn_inv" {
  value = "${template_file.dyn_inv.rendered}"
}
