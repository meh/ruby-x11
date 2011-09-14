#! /usr/bin/env ruby
require 'optparse'
require 'X11/extensions/Xrandr'

options = {}

OptionParser.new do |o|
	options[:get] = true

	o.on '-d', '--display [DISPLAY]', 'the X server to contact' do |value|
		options[:display] = value
	end

	o.on '-S', '--set [PERCENTAGE]' do |value|
		options[:get] = false
		options[:set] = value.to_f
	end

	o.on '-I', '--inc [PERCENTAGE]' do |value|
		options[:get] = false
		options[:inc] = value.to_f
	end

	o.on '-D', '--dec [PERCENTAGE]' do |value|
		options[:get] = false
		options[:dec] = value.to_f
	end

	o.on '-g', '--get' do
		options[:get] = true
	end
end.parse!

