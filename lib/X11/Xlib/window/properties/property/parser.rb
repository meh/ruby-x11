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
# THIS SOFTWARE IS PROVIDED BY <COPYRIGHT HOLDER> ''AS IS'' AND ANY EXPRESS OR IMPLIED
# WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
# FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> OR
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

module X11; class Window < Drawable; class Properties; class Property

module Parser
  @transforms = {
    :default => Transform.new(:default) {
      input do |property, data|
        data
      end

      output do |property, data|
        data
      end
    }
  }

  def self.register (name, &block)
    @transforms[name.to_s] = Transform.new(name, &block)    
  end

  def self.parse (property)
    (@transforms[property.type.to_s] || @transforms[:default]).for(property)
  end

  def self.format (property, data, format)
    real = format.chars.map {|char|
      case char
        when ?c, ?a, ?w then 'L!'
        when ?i, ?b     then 'l!'
        else char
      end
    }.join

    data.bytes.each_slice(data.unpack(real).pack(real).length).map {|s|
      s.map { |d| d.chr }.join.unpack(real).each_with_index.map {|data, index|
        case format[index].chr
          when ?a then Atom.new(data, property.display)
          when ?w then Window.new(property.display, data)
          when ?b then !data.nil? && !data.zero?
          else data
        end
      }
    }
  end
end

end; end; end; end

require 'X11/Xlib/window/properties/property/parser/arc'
require 'X11/Xlib/window/properties/property/parser/atom'
require 'X11/Xlib/window/properties/property/parser/cardinal'
require 'X11/Xlib/window/properties/property/parser/hints'
require 'X11/Xlib/window/properties/property/parser/state'
require 'X11/Xlib/window/properties/property/parser/string'
require 'X11/Xlib/window/properties/property/parser/window'
