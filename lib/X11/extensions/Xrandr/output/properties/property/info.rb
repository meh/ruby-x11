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

module X11; module Xrandr; class Output < ID; class Properties; class Property

class Info
	include ForwardTo

	attr_reader :property
	forward_to  :@instance

	def initialize (property, pointer)
		@property = property
		@internal = pointer.is_a?(C::XRRPropertyInfo) ? pointer : C::XRRPropertyInfo.new(pointer)

		return if nil?

		if range?
			@instance = Range.new(*@internal[:values].read_array_of(:long, 2))
		else
			@instance = @internal[:values].read_array_of(:long, @internal[:num_values])
		end
	end

	def nil?
		@internal[:values].null?
	end

	def range?
		@internal[:range]
	end

	def pending?
		@internal[:pending]
	end

	def immutable?
		@internal[:immutable]
	end

	undef_method :inspect, :to_s

	def to_native
		@internal.pointer
	end
end

end; end; end; end; end
