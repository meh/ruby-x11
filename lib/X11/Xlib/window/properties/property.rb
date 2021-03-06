#--
# Copyleft meh. [http://meh.paranoid.pk | meh@paranoici.org]
#
# Redistribution and use in source and binary forms, with or without modification, are
# permitted provided that the following conditions are met:
#
#    1. Redistributions of source code must retain the above copyright notice, this list of
#       conditions and the following disclaimer.
#
#    2. Redistributions in binary form must reproduce the above copyright notice, this list
#       of conditions and the following disclaimer in the documentation and/or other materials
#       provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY meh ''AS IS'' AND ANY EXPRESS OR IMPLIED
# WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
# FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL meh OR
# CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
# SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
# ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
# NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
# ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
# The views and conclusions contained in the software and documentation are those of the
# authors and should not be interpreted as representing official policies, either expressed
# or implied.
#++

require 'X11/Xlib/window/properties/property/parser'

module X11; class Window < Drawable; class Properties

class Property
	module Mode
		Replace = 0
		Prepend = 1
		Append  = 2

		def self.[] (what)
			what.is_a?(Integer) ? what : const_get(what.to_s.downcase.capitalize)
		end
	end
		
	Transforms = {
		default: Transform.new(:default) {
			output do |property, data|
				data
			end

			input do |property, value, type|
				[value, type]
			end
		}
	}

	def self.register (name, &block)
		Transforms[name.to_s] = Transform.new(name, &block)
	end

	def self.transform (property)
		(Transforms[property.name] || Transforms[:default]).for(property)
	end

	MaxLength = 500000

	extend Forwardable

	attr_reader    :window, :value
	def_delegators :@window, :display
	def_delegators :@atom, :to_s, :to_i, :to_native
	def_delegator  :@atom, :to_s, :name

	def initialize (window, name)
		@window = window
		@atom   = name
	end

	def nil?
		value.nil?
	end

	def value
		type     = FFI::MemoryPointer.new :Atom
		format   = FFI::MemoryPointer.new :int
		length   = FFI::MemoryPointer.new :ulong
		after    = FFI::MemoryPointer.new :ulong
		property = FFI::MemoryPointer.new :pointer

		return unless C::XGetWindowProperty(display.to_native, window.to_native, to_native,
			0, (MaxLength + 3) / 4, false, AnyProperty, type, format, length, after, property).ok?

		return if property.typecast(:pointer).null?

		Property.transform(self).output(Property::Parser.parse(self).output(
			property.typecast(:pointer).read_string(
				[length.typecast(:ulong) * FFI.type_size(
					{ 0 => :void, 8 => :char, 16 => :short, 32 => :long }[format.typecast(:int)]), MaxLength].min)))
	end

	def value= (value, type=nil, mode=:replace)
		type ||= self.type

		format, data, length = Property::Parser.parse(self).input(*Property.transform(self).input(
			value.is_a?(Array) ? value : [value], type))

		C::XChangeProperty(display.to_native, window.to_native, to_native, type.to_native, format, Mode[mode], data, length)

		display.flush
	end

	def << (value, type=nil)
		self.value = value, type, :append
	end

	def >> (value, type=nil)
		self.value = value, type, :prepend
	end

	def type
		@type ? @type : type?
	end

	def type?
		type     = FFI::MemoryPointer.new :Atom
		format   = FFI::MemoryPointer.new :int
		length   = FFI::MemoryPointer.new :ulong
		after    = FFI::MemoryPointer.new :ulong
		property = FFI::MemoryPointer.new :pointer

		return unless C::XGetWindowProperty(display.to_native, window.to_native, to_native,
			0, (MaxLength + 3) / 4, false, AnyProperty, type, format, length, after, property).ok?

		return if property.typecast(:pointer).null?

		Atom.new(type.typecast(:Atom).to_i, display)
	end

	def type!
		@type = nil
		type?
	end

	def type= (type)
		@type = type
	end

	def rotate (positions=1)
		array = FFI::MemoryPointer.new(:Atom)
		array.write(to_native, :Atom)

		C::XRotateWindowProperties(display.to_native, window.to_native, array, 1, positions)
	end

	def inspect
		if nil?
			"#<X11::Window::Property(#{name})>"
		else
			"#<X11::Window::Property(#{name}): #{type}#{" #{value.inspect}" unless value.nil?}>"
		end
	end
end

end; end; end
