#! /usr/bin/env ruby
require 'optparse'
require 'X11/extensions/xf86vmode'
require 'net/http'
require 'json'
require 'sun_time'
require 'sun_time/date_ext'

options = {}

OptionParser.new do |o|
	o.on '-f', '--find [PLACE]', 'Find the latitude of the given location' do |place|
		if place
			JSON.parse(Net::HTTP.get(URI.parse("http://maps.google.com/maps/api/geocode/json?address=#{URI.escape(place)}&sensor=false"))).tap {|data|
				data['results'].each {|result|
					puts "#{result['formatted_address']}: #{result['geometry']['location']['lat']} #{result['geometry']['location']['lng']}"
				}
			}
		else
			Net::HTTP.get(URI.parse('http://www.checkip.org')).tap {|data|
				country   = data.match(/Country: (\w+)/)[1]
				city      = data.match(/City: (\w+)/)[1]
				latitude  = data.match(/Latitude: ([\d.]+)/)[1]
				longitude = data.match(/Longitude: ([\d.]+)/)[1]

				puts "#{country}, #{city}: #{latitude} #{longitude}"
			}
		end
			
		exit!
	end

	o.on '-l', '--location', 'Your current location' do |value|
		options[:latitude], options[:longitude] = value.split ?:
	end
end.parse!

unless options[:latitude] && options[:longitude]
	options[:latitude]  = ARGV.shift or fail 'you have to pass the latitude'
	options[:longitude] = ARGV.shift or fail 'you have to pass the longitude'
end
