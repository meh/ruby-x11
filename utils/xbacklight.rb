#! /usr/bin/env ruby
require 'optparse'
require 'X11/extensions/Xrandr'

options = {}

OptionParser.new do |o|
	o.on '-d', '--display [DISPLAY]', 'the X server to contact' do |value|
		options[:display] = value
	end

	o.on '-s', '--set [PERCENTAGE]' do |value|
		options[:get] = false
		options[:set] = value.to_i
	end

	o.on '-g', '--get' do
		options[:get] = true
	end

	o.on '-I', '--inc [PERCENTAGE]' do |value|
		options[:get] = false
		options[:inc] = value.to_i
	end

	o.on '-D', '--dec [PERCENTAGE]' do |value|
		options[:get] = false
		options[:dec] = value.to_i
	end
end.parse!

X11::Display.open(options[:display]).tap {|display|
	display.default_screen.backlight.tap {|backlight|
		if %w(= + -).include?(ARGV.first) && ARGV.length == 2
			options[{ ?= => :set, ?+ => :inc, ?- => :dec }[ARGV.first]] = ARGV.last.to_i
		end

		if options[:set]
			backlight.set options[:set]
		elsif options[:inc]
			backlight + options[:inc]
		elsif options[:dec]
			backlight - options[:dec]
		else
			puts backlight.to_i
		end
	}
}
