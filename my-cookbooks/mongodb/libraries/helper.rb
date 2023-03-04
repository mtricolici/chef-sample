require 'socket'

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

  def port_open?(port)
    begin
      TCPSocket.new('localhost', port).close
      true
    rescue Errno::ECONNREFUSED, Errno::EHOSTUNREACH, Errno::EADDRNOTAVAIL
      false
    end
  end

  def wait_port_is_open(port, max_attempts = 20, sleep_time = 5)
    attempts = 0
    while !port_open?(port) && attempts < max_attempts do
      attempts += 1
      sleep sleep_time
    end
  end
end

Chef::Recipe.send(:include, Mongo)
Chef::Resource.send(:include, Mongo)
