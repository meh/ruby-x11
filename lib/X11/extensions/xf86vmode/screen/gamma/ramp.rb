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

module X11; module XF86VidMode; class Gamma

class Ramp
	extend Forwardable

	attr_reader    :screen
	def_delegators :screen, :display

	def initialize (screen)
		@screen = screen
	end

	def size
		FFI::MemoryPointer.new(:int).tap! {|p|
			C::XF86VidModeGetGammaRampSize(display.to_ffi, screen.to_i, p)
			p.typecast(:int)
		}
	end

	def get
		red, green, blue = Array.new(3) { FFI::MemoryPointer.new(:ushort, size) }

		C::XF86VidModeGetGammaRamp(display.to_ffi, screen.to_i, size, red, green, blue)

		Struct.new(:red, :green, :blue).new(
			red.read_array_of(:ushort, size),
			green.read_array_of(:ushort, size),
			blue.read_array_of(:ushort, size)
		)
	end

	namedic :red, :green, :blue, :optional => 0 .. -1
	def set (red=nil, green=nil, blue=nil)
		get.tap {|ramps|
			memory = Struct.new(:red, :green, :blue).new(*Array.new(3) { FFI::MemoryPointer.new(:ushort, size) })

			memory.red.write_array_of(:ushort,   red   || ramps.red)
			memory.green.write_array_of(:ushort, green || ramps.green)
			memory.blue.write_array_of(:ushort,  blue  || ramps.blue)

			C::XF86VidModeSetGammaRamp(display.to_ffi, screen.to_i, size, memory.red, memory.green, memory.blue)

			display.flush
		}
	end

	[:red, :green, :blue].each {|color|
		define_method color do
			get[color]
		end

		define_method "#{color}=" do |value|
			set(color => value)[color]
		end
	}
end

end; end; end
