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

module X11; module Xrandr; class Output < ID

class Info
	def self.finalizer (pointer)
		proc {
			C::XRRFreeOutputInfo(pointer)
		}
	end

	def self.get (output)
		new(output, C::XRRGetOutputInfo(output.display.to_ffi, output.resources.to_ffi, output.to_ffi).tap {|info|
			ObjectSpace.define_finalizer info, finalizer(info.to_ffi)
		}
	end

	attr_reader :output

	def initialize (output, pointer)
		@output   = output
		@internal = pointer.is_a?(C::XRROutputInfo) ? pointer : C::XRROutputInfo.new(pointer)
	end

	C::XRROutputInfo.layout.members.each {|name|
		define_method name do
			@internal[name]
		end
	}

	alias width mm_width
	alias height mm_height

	def name
		@internal[:name].read_bytes(@internal[:nameLen])
	end

	def crtc
		Crtc.new(output.resources, @internal[:crtc])
	end

	def crtcs
		Enumerator.new do |e|
			@internal[:crtcs].read_array_of(:RRCrtc, @internal[:ncrtc]).each {|crtc|
				e << Crtc.new(self, crtc)
			}
		end
	end

	def clones
		Enumerator.new do |e|
			@internal[:clones].read_array_of(:RROutput, @internal[:nclone]).each {|clone|
				e << Output.new(self, clone)
			}
		end
	end

	def modes
		Enumerator.new do |e|
			@internal[:modes].read_array_of(:RRMode, @internal[:nmode]).each {|mode|
				e << Mode.new(self, mode)
			}
		end
	end

	def preferred
		Enumerator.new do |e|
			@internal[:modes].read_array_of(:RRMode, @internal[:npreferred]).each {|mode|
				e << Mode.new(self, mode)
			}
		end
	end

	def to_ffi
		@internal.pointer
	end
end

end; end
