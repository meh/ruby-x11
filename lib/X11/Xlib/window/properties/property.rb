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

module X11; class Window; class Properties

class Property
  MaxLength = 500000

  extend Forwardable

  attr_reader    :window, :atom
  def_delegators :@atom, :to_s, :to_i, :to_ffi
  def_delegator  :@atom, :to_s, :name
  def_delegators :@property, :value, :type, :length, :size

  def initialize (window, atom)
    @window = window
    @atom   = atom

    @property = Retarded.new(self) {|p|
      result = OpenStruct.new

      type     = FFI::MemoryPointer.new :Atom
      format   = FFI::MemoryPointer.new :int
      length   = FFI::MemoryPointer.new :ulong
      after    = FFI::MemoryPointer.new :ulong
      property = FFI::MemoryPointer.new :pointer

      return result unless C::XGetWindowProperty(p.window.display.to_ffi, p.window.to_ffi, atom.to_ffi,
        0, (MaxLength + 3) / 4, false, AnyProperty, type, format, length, after, property).ok?

      result.tap {|r|
        r.size   = format.typecast(:int)
        r.length = [length.typecast(:ulong) * (r.size / 8), MaxLength].min
        r.type   = type.typecast(:Atom)
        r.value  = property.typecast(:pointer).typecast(:string)
      }
    }
  end
end

end; end; end
