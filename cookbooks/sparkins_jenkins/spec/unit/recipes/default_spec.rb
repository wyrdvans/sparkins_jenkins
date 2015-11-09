#
# Cookbook Name:: sparkins_jenkins
# Spec:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'sparkins_jenkins::default' do
  context 'When all attributes are default, on an unspecified platform' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'should include the jenkins::master recipe' do
      expect(chef_run).to include_recipe('jenkins::master')
    end

    it 'should install the git plugin' do
      expect(chef_run).to install_jenkins_plugin('git')
    end

    it 'should notify jenkins to restart' do
      git_plugin = chef_run.jenkins_plugin('git')
      expect(git_plugin).to notify('service[jenkins]')
    end
  end
end
