#
# Cookbook:: errbit
# Recipe:: ruby
#

node['errbit']['ruby']['dependencies'].each do |pkg|
  package pkg do
    action :install
  end
end

bash 'install RVM' do
  user errbit_user_id
  group errbit_group
  login true
  creates "#{errbit_home}/.rvm/bin/rvm"
  code <<-EOH
    gpg --keyserver #{node['errbit']['rvm']['keyserver']} --recv-keys #{node['errbit']['rvm']['keys']}
    curl -sSL https://get.rvm.io | bash -s stable
  EOH
  action :run
end

bash 'install ruby' do
  user errbit_user_id
  group errbit_group
  login true
  creates "#{errbit_home}/.rvm/rubies/ruby-#{ruby_version}/bin/ruby"
  code <<-EOH
    source ~/.profile
    rvm install #{ruby_version}
  EOH
  action :run
end
