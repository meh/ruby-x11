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

module X11

class Keysym
	def self.const_missing (name)
		C::XStringToKeysym(name.to_s)
	end

	def self.method_missing (name, *)
		C::XStringToKeysym(name.to_s)
	end

	def self.[] (what, display = nil)
		new(what, display)
	end

	attr_reader :display

	def initialize (value, display = nil)
		if value == 0
			@number = 0
			@string = :any
		elsif value.is_a?(Integer)
			@number = value
			@string = C::XKeysymToString(@number)

			raise ArgumentError, 'invalid keysym' if @string.nil?
		else
			@string = value.to_s
			@number = C::XStringToKeysym(@string).to_i

			raise ArgumentError, 'invalid keysym' if @number.zero?
		end

		@display = display
	end

	def to_keycode
		raise 'no display specified' unless @display

		C::XKeysymToKeycode(display.to_native, to_i)
	end

	def to_s
		@string
	end

	def to_i
		@number
	end
end

end
