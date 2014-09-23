## Scratch2Sphero

With Scratch2Sphero, you can control [Sphero 2.0](http://www.gosphero.com/) from [Scratch 1.4](http://scratch.mit.edu). Tested on MacOS X(10.8.5, 10.9, and 10.9.1).

## Requirements

- [Sphero](http://www.gosphero.com/) - This is the physical robot ball that you'll be controlling
- [Scratch 1.4](http://scratch.mit.edu/scratch_1.4/) - Programing environment
- [hybridgroup-serialport](https://github.com/hybridgroup/ruby-serialport/) - Used by the sphero gem to talk bluetooth
- [sphero gem](https://github.com/hybridgroup/sphero/) - Used by the script to talk to the sphero api

## Installation

```
% git clone https://github.com/champierre/scratch2sphero.git
% bundle install
```

or

```
% git clone https://github.com/champierre/scratch2sphero.git
% ('sudo' if necessary) xcode-select --install # optional step depending on the state of your development tools.  if you get errors building the gems, try this
% ('sudo' if necessary) gem install hybridgroup-serialport
% ('sudo' if necessary) gem install sphero
```

If you cannot use git, you can download the source code from "Download ZIP" button appeared on the right side of the README page.

## Getting Started

### Getting Scratch and Sphero to talk to each other on your Mac

1. Pair your computer with your Sphero.  Do this via the [Bluetooth](https://www.apple.com/support/bluetooth/) pane in settings. Remember, it can only be paired to one device at a time, so turn off bluetooth on any other devices you might be using.
2. On Scratch, right-click on the () Sensor Value block, found in the Sensing category, and 
select the ["Enable remote sensor connections"](http://wiki.scratch.mit.edu/wiki/Remote_Sensors_Protocol) option.
3. On the terminal, run scratch2sphero.rb.  You can then monitor this terminal window for any debug information.

### Movement

1. Use Scratch variable "steps" and Broadcast "move" to make Sphero roll. The number set for "steps" is the duration that Sphero keeps moving.
2. Use Scratch variable "degrees" and Broadcast "turn" to make Sphero turn. The number set for "degrees" is the degree that Sphero turns.
3. (Alternative) Use Broadcast backward/forward/left/right block, found in the Control category, to make Sphero roll to the direction specified. 
4. You can use the following Scratch variables to change the behavior of Sphero.

- speed(default: 20) - roll speed
- initial_heading(default: 0) - initial heading in degree

### LED Control

#### Back LED

  To help your users know which direction the ball is facing, you might want to toggle the back LED

- Use the "back_led_on" broadcast to turn on the little light to tell you were the back of the ball is
- Use the "back_led_off" broadcast to turn the light off

#### Color

  Who doesn't like rainbows?  Especially blinking double rainbows.  You can control the main LED color of Sphero via the color broadcast.
  
- create a global variable named color_name and assign it a [color name](http://www.w3schools.com/html/html_colornames.asp), then broadcast "color".
- you can also define new broadcasts with color_name where name is one of the valid color names, e.g. broadcast "color_cadetblue" or broadcast "color_crimson"
- if you send it an invalid, or blank, color name, it will restore to the saved default color for your Sphero

## Demo Scripts

### Sphero draws square

![Sphero draws square](https://dl.dropboxusercontent.com/u/385564/scratch2sphero/sphero_square.png)

### Sphero makes a rainbow

![Sphero Colors](https://dl.dropboxusercontent.com/s/aghyq2h02mt8vnp/sphero_colors_screenshot.png)

## Demo Movies

### [Scratch x Sphero](https://www.youtube.com/watch?v=aHL03UHULm0)

[![Scratch x Sphero](http://img.youtube.com/vi/aHL03UHULm0/0.jpg)](https://www.youtube.com/watch?v=aHL03UHULm0) 

### [Sphero 2.0 controlled by Scratch(Japanese + English caption)](https://www.youtube.com/watch?v=qCeJ6_UKnk4)

[![Sphero 2.0 controlled by Scratch(Japanese + English caption)](http://img.youtube.com/vi/qCeJ6_UKnk4/0.jpg)](https://www.youtube.com/watch?v=qCeJ6_UKnk4)

### [Sphero colors via Scratch](https://www.youtube.com/watch?v=UoYA4e8f9Ns)

[![Sphero colors via Scratch](http://img.youtube.com/vi/UoYA4e8f9Ns/0.jpg)](https://www.youtube.com/watch?v=UoYA4e8f9Ns)

## Additional Resources

- [Discuss scratch2sphero on the Scratch Forums](http://scratch.mit.edu/discuss/topic/21808/)
- [Scratch's Remote Sensor Control Protocol](http://wiki.scratch.mit.edu/wiki/Remote_Sensors_Protocol)
- [Sphero API](http://orbotixinc.github.io/Sphero-Docs/docs/sphero-api/)
- [Color Names](http://www.w3schools.com/html/html_colornames.asp)
