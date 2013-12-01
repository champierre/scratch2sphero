## Scratch2Sphero

With Scratch2Sphero, you can control [Sphero 2.0](http://www.gosphero.com/) from [Scratch 1.4](http://scratch.mit.edu). Tested on MacOS X(10.8.5).

## Requirements

- [Sphero](http://www.gosphero.com/)
- [Scratch 1.4](http://scratch.mit.edu/scratch_1.4/)
- [sphero gem](https://github.com/tenderlove/sphero)

## Installation

```
% gem install sphero
% git clone git@github.com:champierre/scratch2sphero.git
```

## Getting Started

1. Pair your computer with your Sphero.
2. On Scratch, right-click on the () Sensor Value block, found in the Sensing category, and 
select the "Enable remote sensor connections" option.
3. On the terminal, run scratch2sphero.rb.
4. Use Broadcast backward/forward/left/right block, found in the Control category, to make Sphero roll to the direction specified.
5. You can use the following Scratch variables to change the behavior of Sphero.

- speed(default: 20) - roll speed
- initial_heading(default: 0) - initial heading in degree

## Demo Movies

- [Scratch x Sphero](https://www.youtube.com/watch?v=aHL03UHULm0)
- [Sphero 2.0 controlled by Scratch(Japanese)](https://www.youtube.com/watch?v=qCeJ6_UKnk4)