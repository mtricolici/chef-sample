#
# Cookbook:: errbit
# Recipe:: default
#

include_recipe 'errbit::user_create'
include_recipe 'errbit::ruby_install'
include_recipe 'errbit::errbit_install'
