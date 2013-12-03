#!/usr/bin/env ruby
require_relative "scratchrsc"
require "sphero"
class PrintRSC < RSCWatcher

  def initialize
    super

    sphero_tty = Dir.glob("/dev/tty.Sphero*").first
    @sphero = Sphero.new sphero_tty
    @speed = 20
    @initial_heading = 0
    @current_heading = 0
    @interval = 2

    broadcast "move_10"
    broadcast "turn_90"

    broadcast "forward"
    broadcast "right"
    broadcast "left"
    broadcast "backward"
  end
  
  def on_sensor_update(name, value) # when a variable or sensor is updated
    if name == "speed"
      @speed = value.to_i
    elsif name == "initial_heading"
      @initial_heading = value.to_i
      @current_heading = 0
    elsif name == "interval"
      @interval = value.to_i
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

  def on_broadcast(name)
    (action, argument) = name.split('_')
    case action
    when "move"
      steps = argument.to_i
      sleep_seconds = steps / 10
      _roll(@speed, @initial_heading + @current_heading, sleep_seconds)
    when "turn"
      heading = argument.to_i
      puts "turn #{heading}"
      @current_heading += heading
    end
  end


  private
  def _roll(speed, heading, sleep_seconds = 1)
    if heading < 0
      heading = 360 + heading
    elsif heading > 359
      heading = heading - 360
    end

    puts "roll #{@speed}, #{heading}"
    puts "sleep #{sleep_seconds}"
    @sphero.roll(speed, heading)
    sleep sleep_seconds
    @sphero.stop
    sleep @interval
  end
end

watcher = PrintRSC.new # you can provide the host as an argument
watcher.sensor_update "connected", "1"
loop { watcher.handle_command }
