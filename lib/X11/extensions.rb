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

require 'forwardable'
require 'ostruct'

require 'ffi'
require 'ffi/extra'
require 'versionub'
require 'memoized'
require 'refining'
require 'retarded'
require 'bitmap'
require 'namedic'
require 'with'
require 'on_require'

module Kernel
	def suppress_warnings
		exception = nil
		tmp, $VERBOSE = $VERBOSE, nil

		begin
			result = yield
		rescue Exception => e
			exception = e
		end

		$VERBOSE = tmp

		if exception
			raise exception
		else
			result
		end
	end
end

class Object
	def to_bool
		!!self
	end
end

class Bitmap::Value
	alias to_ffi to_i
end

class Integer
	alias ok? zero?

	def to_ffi
		self
	end
end

class String
	def to_ffi
		self
	end
end

class NilClass
	def to_ffi
		self
	end
end

class FFI::Pointer
	def to_ffi
		self
	end
end

class Array
	def singly
		length == 1 ? first : self
	end
end

module ForwardTo
	def self.included (what)
		what.instance_eval {
			extend Forwardable

			@__forward_to__ = []

			def self.forward_to (*what)
				return @__forward_to__ if what.empty?

				@__forward_to__ << what
				@__forward_to__.flatten!
				@__forward_to__.compact!
				@__forward_to__.uniq!
			end
		}
	end

	def method_missing (name, *args, &block)
		self.class.forward_to.each {|target|
			target = if target.to_s.start_with?('@')
				instance_variable_get target
			else
				if target.is_a?(Array)
					__send__ target.first, *target[1 .. -1]
				else
					__send__ target
				end
			end

			if target.respond_to? name
				return target.__send__ name, *args, &block
			end
		}

		super
	end
end

module X11; module C
	extend FFI::Library
end; end

require 'X11/extension'
