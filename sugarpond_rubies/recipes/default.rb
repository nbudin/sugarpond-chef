#
# Cookbook Name:: sugarpond_rubies
# Recipe:: default
#
# Copyright (C) 2013 YOUR_NAME
# 
# All rights reserved - Do Not Redistribute
#

rbenv_ruby "1.8.7-p371"
rbenv_ruby "1.9.3-p392"

rbenv_gem "passenger" do
  ruby_version "1.9.3-p392"
  version "4.0.0.rc6"
end