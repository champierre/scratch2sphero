#
# scratchrsc.rb is based on the one file library(http://pastebin.com/XCqPeeyW)
# created by Scratcher logiblocs(http://scratch.mit.edu/users/logiblocs/).
#

require "socket"
require "scanf"
 
class RSCWatcher
  def initialize(host="127.0.0.1")
    puts "initialize"
    @socket = TCPSocket.open(host, 42001)
    onConnect
  end

  def sendCommand(cmd)
    i = cmd.length
    @socket.write [i].pack("I").reverse + cmd
  end

  def socket
    @socket
  end

  def handle_command
    message = @socket.recv(@socket.recv(4).reverse.unpack("I")[0]) 
    if message.include? "sensor-update"
      split = message.split
      a = ""
      split.length.times do |i|
        unless i == 0
          if i % 2 == 1
            a = split[i]
          end
          if i % 2 == 0
            on_sensor_update a.gsub(/"/, ''), split[i].gsub(/"/, '')
          end
        end
      end
    end

    if message.include? "broadcast"
      puts message
      split = message.split
      if split.length == 2
        __on_broadcast split[1].gsub(/"/, '')
      end           
    end
  end

  def __on_broadcast(name)
    method = "broadcast_#{name}"
    if self.respond_to? method
      self.send method
    else
      on_broadcast(name)
    end
  end

  def on_broadcast(name)
  end

  def on_sensor_update(name, value)
  end

  def broadcast(name)
    sendCommand("broadcast \"#{name}\"")
  end

  def sensor_update(name,value)
    sendCommand("sensor-update \"#{name}\" \"#{value}\"")
  end

  private
  def onConnect
  end
end
