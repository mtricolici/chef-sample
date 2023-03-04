module Errbit
  def errbit_user
    data_bag_item(node['errbit']['users']['databag'], node['errbit']['users']['id'])
  end

  def errbit_user_id
    errbit_user['id']
  end

  def errbit_group
    errbit_user['groups'][0]
  end

  def errbit_home
    errbit_user['home']
  end
  
  def ruby_version
    node['errbit']['ruby']['version']
  end

  def errbit_dir
    "#{errbit_home}/sources"
  end
end

Chef::Recipe.send(:include, Errbit)
Chef::Resource.send(:include, Errbit)
