#! /usr/bin/env ruby
require 'X11/Xlib'
require 'X11/Xutil'

X11::Display.new.select_window.tap {|window|
  window.properties.each {|property|
    puts property.inspect
  }
}
