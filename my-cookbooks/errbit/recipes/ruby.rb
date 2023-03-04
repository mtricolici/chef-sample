#
# Cookbook:: errbit
# Recipe:: ruby
#

node['errbit']['ruby']['dependencies'].each do |pkg|
  package pkg do
    action :install
  end
end

user = data_bag_item(node['errbit']['users']['databag'], node['errbit']['users']['id'])

bash 'install RVM' do
  user user['id']
  group user['groups'][0]
  login true
  creates "#{user['home']}/.rvm/bin/rvm"
  code <<-EOH
    gpg --keyserver #{node['errbit']['rvm']['keyserver']} --recv-keys #{node['errbit']['rvm']['keys']}
    curl -sSL https://get.rvm.io | bash -s stable
  EOH
  action :run
end

version = node['errbit']['ruby']['version']

bash 'install ruby' do
  user user['id']
  group user['groups'][0]
  login true
  creates "#{user['home']}/.rvm/rubies/ruby-#{version}/bin/ruby"
  code <<-EOH
    source ~/.profile
    rvm install #{version}
  EOH
  action :run
end
