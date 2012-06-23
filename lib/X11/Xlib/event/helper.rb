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

module X11; class Event

Events << nil

Window = [lambda {|w|
	X11::Window.new(display, w)
}, lambda(&:to_native)]

Display = [lambda {|pointer|
	X11::Display.new(pointer)
}, lambda(&:to_native)]

class Helper
	def self.inherited (klass)
		Events << klass
	end

	def self.attribute (which=nil)
		if which
			@attribute = which.to_s.to_sym
		else
			@attribute
		end
	end

	def self.mask (*mask)
		if mask.length > 0
			@mask = mask.flatten.compact.uniq
		else
			@mask
		end
	end

	def self.attach_method (meth, &block)
		return unless block

		class_eval {
			define_method meth do |*args|
				begin
					instance_exec *args, &block
				rescue ArgumentError => e
					raise unless e.message.start_with? 'No such field'

					method_missing(meth, *args)
				end
			end
		}
	end

	def self.manage (name, *args)
		if name.is_a?(Array)
			original, new = name[0, 2]
		else
			original, new = [name] * 2
		end

		args.flatten!

		case args.size
			when 0
				attach_method(new) {
					to_native[self.class.attribute][original]
				}

				attach_method("#{new}=") {|x|
					to_native[self.class.attribute][original] = x
				}
			when 1
				if args.first.is_a?(Class)
					attach_method(new) {
						args.first.new(to_native[self.class.attribute][original])
					}

					attach_method("#{new}=") {|x|
						to_native[self.class.attribute][original] = x.to_native
					}
				else
					manage([original, new], args.first, nil)
				end
			when 2
				attach_method(new) {
					instance_exec(to_native[self.class.attribute][original], &args[0])
				} if args[0]

				attach_method("#{new}=") {|x|
					to_native[attribute][original] = instance_exec(x, &args[1])
				} if args[1]
		end
	end

	manage :serial
	manage [:send_event, :fake?]
	manage :display, X11::Event::Display
	manage :window, X11::Event::Window

	def initialize (struct)
		@struct = struct
	end

	def name
		self.class.name[/[^:]*$/].to_sym
	end

	def mask
		self.class.mask || []
	end

	def attribute
		self.class.attribute
	end

	def matches? (what)
		!!case what
			when Array         then what.any? { |what| matches?(what) }
			when Symbol        then name == what
			when Bitmap::Value then mask.any? { |name| what.has?(name) }
			when Regexp        then name.to_s.match(what)
			when nil           then true
		end
	end

	def to_native
		@struct
	end
end

end; end
