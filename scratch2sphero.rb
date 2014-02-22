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
    @color_name = ''

    broadcast "move"
    broadcast "move_10"

    broadcast "turn"
    broadcast "turn_90"

    broadcast "forward"
    broadcast "right"
    broadcast "left"
    broadcast "backward"
    
    broadcast "color"
    
    broadcast "back_led_on"
    broadcast "back_led_off"
    
    bluetooth_info = @sphero.bluetooth_info
    @sphero_name = bluetooth_info.body.pack('C'*16).strip unless bluetooth_info.nil?
    # there seems to be some timing issue where the bluetooth_info isn't already ready in time when I'm asking for it so this is a quick hack to avoid an error
    # I'm also not sure what it'll do with extended character sets
    @sphero_name = "-->unknown<--" if @sphero_name.nil?
    # this needs more work... when it is unknown we don't seem to have communication with the ball -- somehow I think it is preventing the "Resource Busy" exception?
    puts "Connected to #{@sphero_name}"
  end
  
  def on_sensor_update(name, value) # when a variable or sensor is updated
    value = value.to_i if %w(speed initial_heading steps degrees).include? name
    if name == "speed"
      @speed = value
    elsif name == "initial_heading"
      @initial_heading = value
    elsif name == "steps"
      @steps = value
    elsif name == "degrees"
      @degrees = value
    elsif name == "color_name"
      @color_name = value
    end
    puts "#{@sphero_name} -- #{name} assigned #{value}"
    puts "#{@sphero_name} -- current_heading: #{@current_heading}, absolute_heading: #{@initial_heading + @current_heading}"
  end

  def broadcast_move
    _roll(@speed, @initial_heading + @current_heading, @steps)
  end

  def broadcast_turn
    puts "#{@sphero_name} -- turn #{@degrees}"
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
  
  def broadcast_color
    color
  end

  def broadcast_back_led_on
    back_led_on
  end

  def broadcast_back_led_off
    back_led_off
  end
  
  def on_broadcast(name)
    (action, argument) = name.split('_')
    case action
    when "move"
      steps = argument.to_i
      _roll(@speed, @initial_heading + @current_heading, steps)
    when "turn"
      heading = argument.to_i
      puts "#{@sphero_name} -- turn #{heading}"
      @current_heading += heading
    when "color"
      color(argument)
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

    puts "#{@sphero_name} -- roll #{@speed}, #{heading}"
    @sphero.roll(speed, heading)
    sleep sleep_time
    @sphero.stop
    sleep 1
  end
  
  # sets the color of the sphero, via the @color_name value
  # valid color_names can be found in the COLORS defintion in the sphero gem, which coincide with the 140 named colors CSS uses
  # sending a blank color_name will reset the sphero to the user led color, which is stored in the balls memory
  def color(color_name=@color_name)
    if color_name.empty?
      user_led_color
    else
      begin
        puts "#{@sphero_name} -- color #{color_name}"
        @sphero.color color_name
      rescue => e
        puts "#{@sphero_name} -- unable to set color_name #{color_name}.  #{e.message}"
      end
     end
  end
  
  # reset the color of the sphero to the persistent user selected colour
  def user_led_color()
    puts "#{@sphero_name} -- Reseting color to user_led"
    user_led = @sphero.user_led
    @sphero.rgb user_led.body[0], user_led.body[1], user_led.body[2]
  end
  
  # turns on the back LED so you know which way is forward.
  # it does accept a range between 0x00-0xFF (0-255) but I don't see a need for that atm, just a simple on/off is enough
  def back_led_on()
    puts "#{@sphero_name} -- back LED on"
    @sphero.back_led_output=0xFF
  end

  # turns the back LED off
  def back_led_off()
    puts "#{@sphero_name} -- back LED off"
    @sphero.back_led_output=0x00 # turns off the back led
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
