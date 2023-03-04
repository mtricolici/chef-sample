#
# Cookbook:: mongodb
# Recipe:: default
#

apt_repository 'mongodb' do
  uri "https://repo.mongodb.org/apt/#{node['platform']}"
  components [node['mongodb']['component']]
  distribution node['mongodb']['distribution']
  key 'https://www.mongodb.org/static/pgp/server-5.0.asc'
  action :add
end

apt_package 'mongodb' do
  package_name node['mongodb']['package']
  action :install
end

systemd_unit 'mongodb' do
  unit_name node['mongodb']['systemd']['unit']['name']
  action [:enable, :start]
end
