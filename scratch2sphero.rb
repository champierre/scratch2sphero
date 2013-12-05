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
    @steps = 10
    @degrees = 15

    broadcast "move"
    broadcast "move_10"

    broadcast "turn"
    broadcast "turn_90"

    broadcast "forward"
    broadcast "right"
    broadcast "left"
    broadcast "backward"
  end
  
  def on_sensor_update(name, value) # when a variable or sensor is updated
    value = value.to_i
    if name == "speed"
      @speed = value
    elsif name == "initial_heading"
      @initial_heading = value
    elsif name == "steps"
      @steps = value
    elsif name == "degrees"
      @degrees = value
    end
    puts "current_heading: #{@current_heading}, absolute_heading: #{@initial_heading + @current_heading}"
  end

  def broadcast_move
    _roll(@speed, @initial_heading + @current_heading, @steps)
  end

  def broadcast_turn
    puts "turn #{@degrees}"
    @current_heading += @degrees
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
      _roll(@speed, @initial_heading + @current_heading, steps)
    when "turn"
      heading = argument.to_i
      puts "turn #{heading}"
      @current_heading += heading
    end
  end

  private
  def _roll(speed, heading, steps = 10)
    sleep_time = steps / 10.0
    
    if heading < 0
      heading = heading % 360 + 360
    elsif heading > 359
      heading = heading % 360
    end

    puts "roll #{@speed}, #{heading}"
    @sphero.roll(speed, heading)
    sleep sleep_time
    @sphero.stop
    sleep 1
  end
end

begin
  watcher = PrintRSC.new # you can provide the host as an argument
  watcher.sensor_update "connected", "1"
  loop { watcher.handle_command }
rescue Errno::ECONNREFUSED
  puts "\033[31m\033[1mError: Scratch may not be running or remote sensor connections are not enabled.\033[00m\n"
rescue => e
  puts "\033[31m\033[1mError: #{e.message}\033[00m\n"
end
