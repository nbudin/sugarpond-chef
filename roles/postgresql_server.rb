name 'postgresql_server'
description "PostgreSQL server"

run_list(
  "role[debian]",
  "recipe[postgresql]",
  "recipe[postgresql::server]",
  "recipe[sugarpond_backups::postgresql]"
)

override_attributes(
  "postgresql" => {
    "config" => {
      "listen_addresses" => "0.0.0.0"
    },
    "password" => {
      "postgres" => ""
    },
    "pg_hba" => [
      {
        :type => "hostssl", :db => 'all', :user => 'all', :addr => "0.0.0.0/0", :method => 'md5'
      }
    ]
  },
  "sugarpond_backups" => {
    "postgresql" => {
      "s3_bucket" => "nbudin"
    }
  }
)