#
# Cookbook:: mongo
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.
apt_update 'update_sources' do
  action :update
end

service 'mongod' do
  support status: true, start: true, restart: true, reload: true, enable: true,
  action [:start,:enable]
end

apt_repository 'mongodb-org' do
  uri "http://repo.mongodb.org/apt/ubuntu"
  distribution 'trusty/mongodb-org/3.2'
  components ['multiverse']
  keyserver 'hkp://keyserver.ubuntu.com:80'
  key 'EA312927'
  action :add
end

package 'mongodb-org' do
  action :install
  options "--allow-unauthenticated"
end

service 'mongodb-org' do
  action [:enable, :start]
  options "--allow-unauthentication"
end

template '/etc/mongodb.conf' do
  source 'mongodb.conf.erb'
  mode '0600'
  owner 'root'
  group 'root'
  notifies :restart, 'service[mongod]'
end

template '/etc/systemd/system/mongod.service' do
  source 'mongodb.conf.erb'
  mode '0755'
  owner 'root'
  group 'root'
  notifies :restart, 'service[mongod]'
end
