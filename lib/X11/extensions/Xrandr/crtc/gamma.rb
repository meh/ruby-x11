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

module X11; module Xrandr; class Crtc < ID

class Gamma
	def self.finalizer (pointer)
		proc {
			C::XRRFreeCrtcGamma(pointer)
		}
	end

	def self.get (crtc)
		new(crtc, C::XRRGetCrtcGamma(crtc.display.to_native, crtc.to_native)).tap {|gamma|
			ObjectSpace.define_finalizer gamma, finalizer(gamma.to_native)
		}
	end

	def self.create (crtc)
		new(crtc, C::XRRAllocGamma(C::XRRGetCrtcGammaSize(crtc.display.to_native, crtc.to_native))).tap {|gamma|
			ObjectSpace.define_finalizer gamma, finalizer(gamma.to_native)
		}
	end

	attr_reader :crtc

	def initialize (crtc, pointer)
		@crtc     = crtc
		@internal = pointer.is_a?(C::XRRCrtcGamma) ? pointer : C::XRRCrtcGamma.new(pointer)
	end

	def size
		@internal[:size]
	end

	[:red, :green, :blue].each {|name|
		define_method name do
			@internal[name].read_array_of(:ushort, size)
		end

		define_method "#{name}=" do |value|
			@internal[name].write_array_of(:ushort, value)
		end

		define_method "#{name}!" do |value|
			__send__ "#{name}=", value
			save!
		end
	}

	def get
		Struct.new(:red, :green, :blue).new(red, green, blue)
	end

	named :red, :green, :blue, :optional => 0 .. -1
	def set (red=nil, green=nil, blue=nil)
		self.red   = red   if red
		self.green = green if green
		self.blue  = blue  if blue

		save!
	end

	def save!
		C::XRRSetCrtcGamma(crtc.display.to_native, crtc.to_native, to_native)
		crtc.display.flush
		self
	end

	def to_native
		@internal.pointer
	end
end

end; end; end
