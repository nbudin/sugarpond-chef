name 'app_server'
description "App server with nginx and passenger"

run_list(
  "role[debian]",
  "recipe[rbenv]",
  "recipe[rbenv::ruby_build]",
  "recipe[sugarpond_rubies]",
  "recipe[nginx]",
  "recipe[mysql]",
  "recipe[postgresql]"
)

override_attributes "nginx" => {
  "install_method" => "source",
  "gzip" => "on",
  "init_style" => "upstart",
  "source" => {
    "modules" => ["http_ssl_module", "passenger"]
  },
  "passenger" => {
    "version" => "4.0.0.rc6",
    "ruby" => "/opt/rbenv/versions/1.9.3-p392/bin/ruby",
    "root" => "/opt/rbenv/versions/1.9.3-p392/lib/ruby/gems/1.9.1/gems/passenger-4.0.0.rc6"
  }
}