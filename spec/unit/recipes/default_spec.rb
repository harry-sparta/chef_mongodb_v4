#
# Cookbook:: mongo_v4
# Spec:: default
#
# Copyright:: 2020, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'mongo_v4::default' do
  context 'When all attributes are default, on Ubuntu 18.04' do
    # for a complete list of available platforms and versions see:
    # https://github.com/chefspec/fauxhai/blob/master/PLATFORMS.md
    platform 'ubuntu', '18.04'
  end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

  # context 'When all attributes are default, on CentOS 7' do
  #   # for a complete list of available platforms and versions see:
  #   # https://github.com/chefspec/fauxhai/blob/master/PLATFORMS.md
  #   platform 'centos', '7'

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'should install mongodb' do
      expect(chef_run).to run_execute 'mongodb_install'
    end

    it 'should create a mongod.conf template in /etc' do
      expect(chef_run).to create_template('/etc/mongod.conf').with_variables(port: 27017, bindIp: '0.0.0.0')
    end

    it 'runs apt-get update' do
      expect(chef_run).to update_apt_update 'update_sources'
    end
end
