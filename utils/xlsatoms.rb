#! /usr/bin/env ruby
require 'optparse'
require 'X11/Xlib'

options = {}

OptionParser.new do |o|
	options[:format] = "%d\t%s"

	o.on '-d', '--display DISPLAY', 'the X server to contact' do |value|
		options[:display] = value
	end

	o.on '-f', '--format FORMAT', 'prinf-style format to use' do |format|
		options[:format] = format
	end

	o.on '-n', '--name NAME', 'name of single atom to print' do |name|
		options[:name] = name
	end

	o.on '-r', '--range RANGE' 'atom values to list' do |range|
		options[:range] = range[/^(.*)-/][0 .. -2].to_i .. range[/-(.*)$/][1 .. -1].to_i
	end
end.parse!

X11::Display.open(options[:display]).tap {|display|
	if options[:name]
		display.atom(options[:name]).tap {|atom|
			puts options[:format] % [atom.to_i, atom.to_s]
		}
	elsif options[:range]
		options.each {|index|
			display.atom(index).tap {|atom|
				puts options[:format] % [atom.to_i, atom.to_s]
			}
		}
	else
		current = 1
		while (atom = display.atom(current)).exists?
			puts options[:format] % [atom.to_i, atom.to_s]
			current += 1
		end
	end
}

