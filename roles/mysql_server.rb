name 'mysql_server'
description "MySQL server"

run_list(
  "role[debian]",
  "recipe[mysql]",
  "recipe[mysql::server]",
  "recipe[sugarpond_backups::mysql]",
  "recipe[sugarpond_mysql_ssl]"
)

override_attributes "mysql" => {
  "server_root_password" => "",
  "bind-address" => "0.0.0.0"
}