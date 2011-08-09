#! /usr/bin/env ruby
require 'optparse'
require 'X11/simple'

options = {}

OptionParser.new do |o|
  options[:config] = "#{ENV['HOME']}/.rtilerc"

  o.on '-c', '--config CONFIG', 'The configuration file to use' do |path|
    options[:config] = path if path
  end

  o.on '-D', '--display DISPLAY', 'X display to use' do |name|
    options[:display] = name
  end

  o.on '-s', '--select', 'Select a window' do
    options[:select] = true
  end

  o.on '-f', '--focus', 'Use focused window as target' do
    options[:focus] = true
  end
end.parse!

Class.new {
  def initialize (display, path, options={})
    @display = display
    @options = options

    instance_eval File.read(path), path, 1
  end

  def display (name=nil, &block)
    return unless name == @display

    @display = X11::Display.new(name)

    if @options[:select]
      @select = @display.select_window(true) if @select
    elsif @options[:focus]
      @focus = @display.focused
    end

    instance_exec @display, &block
  end

  def window (data, &block)
    return if @select or @focus

    @display.default_screen.windows.each {|window|
      block.call(window) if matches?(data, window)
    }
  end

  def select (&block)
    return unless @select

    block.call(@select)
  end

  def focus (&block)
    return unless @focus

    block.call(@focus)
  end

  def matches? (data, window)
    data.any? {|name, value|
      value = [value].flatten

      if name == :name
        compare_to = window.properties[:WM_CLASS].value
      elsif name == :title
        compare_to = [window.title]
      else
        raise RuntimeError
      end rescue next

      value.any? {|what|
        if what.is_a?(Regexp)
          compare_to.any? {|compare|
            compare.match(what)
          }
        else
          compare_to.any? {|compare|
            what.to_s == compare
          }
        end
      }
    }
  end
}.new(options[:display], options[:config], select: options[:select], focus: options[:focus])
