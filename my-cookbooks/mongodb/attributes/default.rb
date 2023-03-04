
case node['platform']
when 'debian'
  default['mongodb']['component'] = 'main'
  default['mongodb']['distribution'] = "#{node['lsb']['codename']}/mongodb-org/5.0"
  default['mongodb']['package'] = 'mongodb-org'
  default['mongodb']['systemd']['unit']['name'] = 'mongod'
when 'ubuntu'
  default['mongodb']['component'] = 'multiverse'
  default['mongodb']['distribution'] = "#{node['lsb']['codename']}/mongodb-org/5.0"
  default['mongodb']['package'] = 'mongodb-org'
  default['mongodb']['systemd']['unit']['name'] = 'mongod'
else
  raise 'Unsupported platform'
end

default['mongodb']['databag']['name'] = 'passwords'
default['mongodb']['databag']['item'] = 'mongodb'
