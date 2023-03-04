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

