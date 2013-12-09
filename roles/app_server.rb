name 'app_server'
description "App server with nginx and passenger"

run_list(
  "role[debian]",
  "recipe[rbenv]",
  "recipe[rbenv::ruby_build]",
  "recipe[sugarpond_rubies]",
  "recipe[nginx]",
  "recipe[mysql]",
  "recipe[mysql::ruby]",
  "recipe[postgresql]",
  "recipe[postfix]",
  "recipe[postfix::sasl_auth]",
  "recipe[sugarpond_logrotate]"
)

override_attributes(
  "nginx" => {
    "version" => "1.4.4",
    "install_method" => "source",
    "gzip" => "on",
    "init_style" => "upstart",
    "source" => {
      "modules" => ["nginx::http_ssl_module", "nginx::http_spdy_module", "nginx::passenger"]
    },
    "passenger" => {
      "version" => "4.0.25",
      "ruby" => "/opt/rbenv/versions/2.0.0-p353/bin/ruby",
      "root" => "/opt/rbenv/versions/2.0.0-p353/lib/ruby/gems/2.0.0/gems/passenger-4.0.25"
    }
  }, 
  "postfix" => {
    "smtp_sasl_auth_enable" => "yes",
    "smtp_sasl_security_options" => "noanonymous",
    "smtp_sasl_user_name" => "natbudin@gmail.com",
    "smtp_tls_cafile" => "",
    "relayhost" => "[smtp.mandrillapp.com]:587",
    "smtp_use_tls" => "yes"
  },
  "users" => ['www-data', 'deploy'],
  "firewall" => {
    "rules" => [
      { "http" => { "port" => 80 } },
      { "https" => { "port" => 443 } }
    ]
  }
)
