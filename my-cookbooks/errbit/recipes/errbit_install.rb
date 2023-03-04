#
# Cookbook:: errbit
# Recipe:: errbit_install
#

directory errbit_dir do
  owner errbit_user_id
  group errbit_group
  mode '0755'
  action :create
end

git 'errbit' do
  repository 'https://github.com/errbit/errbit.git'
  revision 'main'
  destination errbit_dir
  user errbit_user_id
  group errbit_group
  action :checkout
  not_if { ::File.exists?("#{errbit_dir}/.clone.once") }
  notifies :create, 'file[errbit_git_lock]', :immediately
end

file 'errbit_git_lock' do
  path "#{errbit_dir}/.clone.once"
  content 'something'
  action :nothing
end

bash 'bundle install' do
  user errbit_user_id
  group errbit_group
  login true
  cwd errbit_dir
  code <<-EOH
    source ~/.profile
    gem update bundler
    bundle install
  EOH
  action :run
end

template "#{errbit_dir}/.env" do
  source 'env.erb'
  owner errbit_user_id
  group errbit_group
  mode '0600'
  variables(dbuser: mongodb_user, dbpass: mongodb_password)
  action :create
end

bash 'errbit bootstrap' do
  user errbit_user_id
  group errbit_group
  login true
  cwd errbit_dir
  code <<-EOH
    source ~/.profile
    bundle exec rake errbit:bootstrap
  EOH
  action :run
end

template '/etc/systemd/system/errbit.service' do
  source 'errbit.service.erb'
  owner 'root'
  group 'root'
  mode '0644'
  variables(user: errbit_user_id, dir: errbit_dir, port: errbit_port, interface: errbit_interface)
  action :create
  notifies :reload, 'systemd_unit[errbit.service]', :immediately
end

systemd_unit 'errbit.service' do
  triggers_reload true
  action [:enable, :start]
end

# I tried with :notifies and :subscribes . only this HACK works :)
ruby_block 'wait errbit to start' do
  block do
    wait_until_port_is_open(node['errbit']['port'])
  end
  action :run
end

