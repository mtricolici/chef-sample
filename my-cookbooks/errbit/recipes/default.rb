#
# Cookbook:: errbit
# Recipe:: default
#

errbit_user = data_bag_item(node['errbit']['users']['databag'], node['errbit']['users']['id'])

#puts "\ndebug errbit_user = '#{errbit_user.to_hash}'\n\n"
#puts "\nhome dir is '#{errbit_user['home']}'\n"

users_manage 'errbit' do
  action [:create]
  users [errbit_user]
end

