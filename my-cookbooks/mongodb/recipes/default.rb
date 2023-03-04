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

# I tried with :notifies and :subscribes . only this HACK works :)
ruby_block 'wait mongodb to start' do
  block do
    wait_port_is_open(27017)
  end
  action :run
end

bash 'mongodb create user' do
  user 'root'
  group 'root'
  login true
  code <<-EOH
      mongosh <<EOF
      use admin
      if (db.getCollection("system.users").find({"user": "#{mongodb_user}"}).toArray().length === 0) {
          db.createUser({user: "#{mongodb_user}", pwd: "#{mongodb_password}", roles: ["readWrite"]})
      }
      EOF
  EOH
end
