require 'socket'

module Common
  def port_open?(port)
    begin
      TCPSocket.new('localhost', port).close
      true
    rescue Errno::ECONNREFUSED, Errno::EHOSTUNREACH, Errno::EADDRNOTAVAIL
      false
    end
  end

  def wait_until_port_is_open(port, max_attempts = 20, sleep_time = 5)
    attempts = 0
    while !port_open?(port) && attempts < max_attempts do
      attempts += 1
      sleep sleep_time
    end
  end
end

Chef::Recipe.send(:include, Common)
Chef::Resource.send(:include, Common)
