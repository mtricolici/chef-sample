#
# Cookbook:: errbit
# Recipe:: default
#

# Create errbit user
include_recipe 'errbit::user'

# Install rvm and ruby in errbit user home directory
include_recipe 'errbit::ruby'
