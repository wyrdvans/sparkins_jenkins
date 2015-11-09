#
# Cookbook Name:: sparkins_jenkins
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.
include_recipe 'jenkins::master'

jenkins_plugin 'git' do
  notifies :restart, 'service[jenkins]', :immediately
end
