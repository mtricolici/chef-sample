#
# Cookbook:: errbit
# Recipe:: user
#

users_manage errbit_user_id do
  action [:create]
  users [errbit_user]
end
