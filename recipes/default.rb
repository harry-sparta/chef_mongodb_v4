#
# Cookbook:: mongo_v4
# Recipe:: default
#
# Copyright:: 2020, The Authors, All Rights Reserved.

# --------- BASH COMMANDS FOR MONGODB INSTALL
execute 'mongod_apt_key'do
  command 'wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | sudo apt-key add -'
  action :run
end

execute 'mongod_update_sourcelist' do
  command "echo 'deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.2 multiverse' | sudo tee /etc/apt/sources.list.d/mongodb-org-4.2.list"
  action :run
end

execute 'apt-update' do
  command 'sudo apt-get update -y'
  action :run
end

execute 'mongodb_install' do
  command 'sudo apt-get install -y mongodb-org'
  action :run
end

# execute 'mongod_provision_script' do
#   command 'sudo systemctl restart mongod'
#   action :run
# end
#
# execute 'mongod_provision_script' do
#   command 'sudo systemctl enable mongod'
#   action :run
# end

service 'mongod' do
  action [:start, :enable]
end

# resource template
template '/etc/mongod.conf' do
  source 'mongod.conf.erb'
  variables port: node['mongod']['port'], bindIp: node['mongod']['bindIp']
  notifies :restart, 'service[mongod]'
end


template '/lib/systemd/system/mongod.service' do
  source 'mongod.service.erb'
  notifies :restart, 'service[mongod]'
end
