#
# Cookbook Name:: sparkins_jenkins
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.
include_recipe 'jenkins::master'

include_recipe 'git'

package 'mailutils'

%w(git email-ext).each do |plugin|
  jenkins_plugin plugin do
    notifies :restart, 'service[jenkins]', :immediately
  end
end

sparkins_config_filename = File.join(Chef::Config[:file_cache_path], 'sparkins-config.xml')

template sparkins_config_filename do
  source 'sparkins-config.xml.erb'
end

jenkins_job 'sparkins' do
  config sparkins_config_filename
  action :create
end
