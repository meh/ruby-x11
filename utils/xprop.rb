#! /usr/bin/env ruby
require 'optparse'
require 'X11/simple'

options = {}

OptionParser.new do |o|
  options[:frame] = false

  o.on '-f', '--frame', 'Do not try to find the client in virtual roots' do
    options[:frame] = true
  end
end.parse!


X11::Display.new.select_window(options[:frame]).tap {|window|
  window.properties.each {|property|
    puts "#{property.name}(#{property.type}) = #{property.value.singly}"
  }
}
