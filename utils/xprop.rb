#! /usr/bin/env ruby
require 'optparse'
require 'X11/simple'
require 'ap'

options = {}

OptionParser.new do |o|
  options[:frame] = false

  o.on '-f', '--frame', 'Do not try to find the client in virtual roots' do
    options[:frame] = true
  end
end.parse!

module Output
  @outputs = {
    String => lambda {|item|
      item.inspect
    },

    X11::Window => lambda {|item|
      "window id # #{item.id}"
    }
  }

  def self.do (item)
    if tmp = @outputs[item.class]
      tmp.call(item)
    else
      if item.method(:to_s).owner == item.class
        item.to_s
      else
        item.inspect
      end
    end
  end
end

X11::Display.new.select_window(options[:frame]).tap {|window|
  window.properties.each {|property|
    if property.value.is_a?(Array)
      puts "#{property.name}(#{property.type}) = #{property.value.map { |i| Output.do(i) }.join(', ')}"
    else
      puts "#{property.name}(#{property.type}) = #{property.value.bytes.map { |b| "%02X" % b }.join ' '}"
    end
  }
}
