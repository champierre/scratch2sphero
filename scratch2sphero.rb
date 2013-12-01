require_relative "scratchrsc"
require "sphero"
class PrintRSC < RSCWatcher

  def initialize
    super

    sphero_tty = Dir.glob("/dev/tty.Sphero*").first
    @sphero = Sphero.new sphero_tty
    @speed = 20
    @initial_heading = 0  

    broadcast "forward"
    broadcast "right"
    broadcast "backward"
    broadcast "left"
  end
  
  def on_sensor_update(name, value) # when a variable or sensor is updated
    if name == "speed"
      @speed = value.to_i
    elsif name == "initial_heading"
      @initial_heading = value.to_i
    end
  end

  def broadcast_right
    heading = @initial_heading + 90
    _roll(@speed, heading)
  end
  
  def broadcast_left
    heading = @initial_heading + 270
    _roll(@speed, heading)
  end

  def broadcast_forward
    heading = @initial_heading
    _roll(@speed, heading)
  end

  def broadcast_backward
    heading = @initial_heading + 180
    _roll(@speed, heading)
  end

  private
  def _roll(speed, heading)
    if heading < 0
      heading = 360 + heading
    elsif heading > 360
      heading = heading - 360
    end

    puts "roll #{@speed}, #{heading}"
    @sphero.roll(speed, heading)
  end
end

watcher = PrintRSC.new # you can provide the host as an argument
watcher.sensor_update "connected", "1"
loop { watcher.handle_command }
