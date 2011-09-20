#! /usr/bin/env ruby
require 'optparse'
require 'X11/extensions/xf86vmode'

options = {}

OptionParser.new do |o|
	o.on '-d', '--display DISPLAY', 'the X server to contact' do |value|
		options[:display] = value
	end

	o.on '-s', '--screen NUMBER', Integer, 'the screen number to act on' do |value|
		options[:screen] = value
	end
	
	o.on '-q', '--quiet' do
		options[:quiet] = true
	end

	o.on '-G', '--gamma VALUE', Float, 'gamma value' do |value|
		options[:gamma] = value
	end

	o.on '-r', '--rgamma VALUE', Float, 'red gamma value' do |value|
		options[:red] = value
	end
	
	o.on '-g', '--ggamma VALUE', Float, 'green gamma value' do |value|
		options[:green] = value
	end

	o.on '-b', '--bgamma VALUE', Float, 'blue gamma value' do |value|
		options[:blue] = value
	end
end.parse!

X11::Display.open(options[:display]).tap {|display|
	(options[:screen] ? display.screen(options[:screen]) : display.default_screen).tap {|screen|
		screen.gamma.tap {|gamma|
			puts "-> Red #{"%6.3f" % gamma.red}, Green #{"%6.3f" % gamma.green}, Blue #{"%6.3f" % gamma.blue}" unless options[:quiet]

			if options[:gamma] || options[:red] || options[:green] || options[:blue]
				gamma.set(options[:red] || options[:gamma], options[:green] || options[:gamma], options[:blue] || options[:gamma])

				puts "<- Red #{"%6.3f" % gamma.red}, Green #{"%6.3f" % gamma.green}, Blue #{"%6.3f" % gamma.blue}" unless options[:quiet]
			end
		}
	}
}
