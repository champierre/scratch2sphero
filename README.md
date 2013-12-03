## Scratch2Sphero

With Scratch2Sphero, you can control [Sphero 2.0](http://www.gosphero.com/) from [Scratch 1.4](http://scratch.mit.edu). Tested on MacOS X(10.8.5 and 10.9).

## Requirements

- [Sphero](http://www.gosphero.com/)
- [Scratch 1.4](http://scratch.mit.edu/scratch_1.4/)
- [hybridgroup-serialport](https://github.com/hybridgroup/ruby-serialport/)
- [sphero gem](https://github.com/hybridgroup/sphero/)

## Installation

```
% git clone git@github.com:champierre/scratch2sphero.git
% bundle install
```

or

```
% git clone git@github.com:champierre/scratch2sphero.git
% gem install hybridgroup-serialport
% gem install sphero
```

## Getting Started

1. Pair your computer with your Sphero.
2. On Scratch, right-click on the () Sensor Value block, found in the Sensing category, and 
select the "Enable remote sensor connections" option.
3. On the terminal, run scratch2sphero.rb.
4. Use Broadcast move_10, found in the Control category, to make Sphero roll. The number after "move_" is the duration that Sphero keeps moving. You can send "move_20", "move_30"... to make Sphero move longer.
5. Use Broadcast turn_90 to make Sphero turn. The number after "turn_" is the degree that Sphero turns.
6. (Alternative) Use Broadcast backward/forward/left/right block, found in the Control category, to make Sphero roll to the direction specified.
7. You can use the following Scratch variables to change the behavior of Sphero.

- speed(default: 20) - roll speed
- initial_heading(default: 0) - initial heading in degree
- interval(default: 2) - interval between each move



## Demo Movies

- [Scratch x Sphero](https://www.youtube.com/watch?v=aHL03UHULm0)
- [Sphero 2.0 controlled by Scratch(Japanese)](https://www.youtube.com/watch?v=qCeJ6_UKnk4)
