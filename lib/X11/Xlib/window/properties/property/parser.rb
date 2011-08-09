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

module X11; class Window; class Properties; class Property

module Parser
  @parsers = {}

  def self.register (name, &block)
    @parsers[name.to_s] = block
  end

  def self.parse (property, data)
    return data unless @parsers[property.type.to_s]

    @parsers[property.type.to_s].call(property, data)
  end

  def self.format (property, data, format)
    data.unpack(format.chars.map {|char|
      case char
        when 'c'           then 'L!'
        when 'i', 'a', 'b' then 'l!'
        else char
      end
    }.join).each_with_index.map {|data, index|
      case format[index].chr
        when 'a' then Atom.new(data, property.display)
        when 'b' then !data.zero?
        else data
      end
    }
  end

  def self.string (data, type)

  end
end

end; end; end; end

require 'X11/Xlib/window/properties/property/parser/arc'
require 'X11/Xlib/window/properties/property/parser/atom'
require 'X11/Xlib/window/properties/property/parser/cardinal'