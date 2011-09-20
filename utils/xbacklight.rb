#! /usr/bin/env ruby
require 'optparse'
require 'X11/extensions/Xrandr'

options = {}

OptionParser.new do |o|
	o.on '-d', '--display DISPLAY', 'the X server to contact' do |value|
		options[:display] = value
	end

	o.on '-S', '--set PERCENTAGE' do |value|
		options[:get] = false
		options[:set] = value.to_i
	end

	o.on '-G', '--get' do
		options[:get] = true
	end

	o.on '-I', '--inc PERCENTAGE', Integer do |value|
		options[:get] = false
		options[:inc] = value
	end

	o.on '-D', '--dec PERCENTAGE', Integer do |value|
		options[:get] = false
		options[:dec] = value
	end

	o.on '-t', '--time MILLISECONDS', Integer, 'fade time in milliseconds' do |value|
		options[:time] = value
	end

	o.on '-s', '--steps STEPS', Integer, 'number of steps in fade' do |value|
		options[:steps] = value
	end
end.parse!

X11::Display.open(options[:display]).tap {|display|
	display.default_screen.backlight.tap {|backlight|
		if %w(= + -).include?(ARGV.first) && ARGV.length == 2
			options[{ ?= => :set, ?+ => :inc, ?- => :dec }[ARGV.first]] = ARGV.last.to_i
		end

		if options[:set] || options[:inc] || options[:dec]
			if options[:steps] || options[:time]
				options[:time]  ||= 200
				options[:steps] ||= 20
			end

			current = backlight.get
			new     = if options[:set]
				options[:set]
			elsif options[:inc]
				current + options[:inc]
			elsif options[:dec]
				current - options[:dec]
			end.tap! {|n|
				if n < 0
					0
				elsif n > 100
					100
				else
					n
				end
			}

			if options[:steps]
				if current > new
					-current .. -new
				else
					current .. new
				end.step(options[:steps]) {|i|
					backlight.set(i.abs)

					sleep options[:time] / 1000.0 / options[:steps]
				}
			else
				backlight.set new
			end
		else
			puts backlight.to_i
		end
	}
}
