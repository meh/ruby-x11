#! /usr/bin/env ruby
require 'optparse'
require 'X11/simple'

options = {}

OptionParser.new do |o|
  options[:frame] = false
  options[:root]  = false

  o.on '-D', '--display [DISPLAY]', 'the X server to contact' do |value|
    options[:display] = value
  end

  o.on '-f', '--frame', "don't ignore window manager frames" do
    options[:frame] = true
  end

  o.on '-S', '--spy', 'examine window properties forever' do
    options[:spy] = true
  end

  o.on '-i', '--id [ID]', 'resource id of window to examine' do |value|
    options[:id] = value
  end

  o.on '-r', '--root', 'examine the root window' do
    options[:root] = true
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

X11::Display.open(options[:display]).tap {|display|
  if options[:id]
    display.window(options[:id])
  elsif options[:root]
    display.root_window
  else
    display.select_window(options[:frame])
  end.tap {|window|
    window.properties.each {|property|
      output = if property.value.is_a?(String)
        property.value.bytes.map { |b| "0x%X" % b }.join ', '
      else
        Output.do(property)
      end

      puts "#{property.name}(#{property.type})#{output.include?(?\n) ? ':' : ' = '}#{output}"
    }
  }
}
