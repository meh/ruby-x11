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

module Output
  @outputs = {
    :WM_STATE => lambda {|property|
      "\n\t\twindow state: #{property.value.first}\n\t\ticon window: 0x#{property.value.last.to_i.to_s(16)}"
    },

    :WM_COMMAND => lambda {|property|
      "{ #{property.value.map { |s| s.inspect }.join(', ')} }"
    },

    String => lambda {|item|
      item.inspect
    },

    X11::Window => lambda {|item|
      "window id # 0x#{item.to_i.to_s(16)}"
    }
  }

  def self.do (property)
    if tmp = @outputs[property.name.to_sym]
      tmp.call(property)
    else
      property.value.map {|item|
        if tmp = @outputs[item.class]
          tmp.call(item)
        else
          if item.method(:to_s).owner == item.class
            item.to_s
          else
            item.inspect
          end
        end
      }.join(', ')
    end
  end
end

X11::Display.open.select_window(options[:frame]).tap {|window|
  window.properties.each {|property|
    output = if property.value.is_a?(String)
      property.value.bytes.map { |b| "0x%X" % b }.join ', '
    else
      Output.do(property)
    end

    puts "#{property.name}(#{property.type})#{output.include?(?\n) ? ':' : ' = '}#{output}"
  }
}
