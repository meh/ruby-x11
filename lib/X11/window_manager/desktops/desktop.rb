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

module X11; class WindowManager; class Desktops

class Desktop
	attr_reader :name, :index, :window

	def initialize (parent, name, index, window)
		@parent = parent
		@name   = name
		@index  = index
		@window = window
	end

	def size
		begin
			geometry = @parent.wm.root.properties[:_NET_DESKTOP_GEOMETRY].value

			Struct.new(:width, :height).new(geometry[0], geometry[2])
		rescue
			Supports.raise :_NET_DESKTOP_GEOMETRY
		end
	end

	def starts_at
		begin
			viewport = @parent.wm.root.properties[:_NET_DESKTOP_VIEWPORT].value

			Struct.new(:x, :y).new(viewport[0], viewport[2])
		rescue
			Supports.raise :_NET_DESKTOP_VIEWPORT
		end
	end

	def current?
		begin
			@parent.wm.root.properties[:_NET_CURRENT_DESKTOP].value.first == index
		rescue
			Supports.raise :_NET_CURRENT_DESKTOP
		end
	end

	def to_s
		name
	end

	def inspect
		"#<Desktop[#{index}]: #{to_s.inspect} #{size.width}x#{size.height} (#{starts_at.x}; #{starts_at.y})>"
	end
end

end; end; end
