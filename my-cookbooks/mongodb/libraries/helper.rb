module Mongo
  def mongodb_user_entry
    data_bag_item(node['mongodb']['databag']['name'], node['mongodb']['databag']['item'])
  end

  def mongodb_user
    mongodb_user_entry['user']
  end

  def mongodb_password
    mongodb_user_entry['password']
  end
end

Chef::Recipe.send(:include, Mongo)
Chef::Resource.send(:include, Mongo)
