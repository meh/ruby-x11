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

class Status
  @codes = {
    :Success           => 0,
    :BadRequest        => 1,
    :BadValue          => 2,
    :BadWindow         => 3,
    :BadPixmap         => 4,
    :BadAtom           => 5,
    :BadCursor         => 6,
    :BadFont           => 7,
    :BadMatch          => 8,
    :BadDrawable       => 9,
    :BadAccess         => 10,
    :BadAlloc          => 11,
    :BadColor          => 12,
    :BadGC             => 13,
    :BadIDChoice       => 14,
    :BadName           => 15,
    :BadLength         => 16,
    :BadImplementation => 17,

    :FirstExtensionError => 128,
    :LastExtensionError  => 255
  }

  def self.to_hash
    @codes
  end

  def self.const_missing (const)
    Status.new(to_hash[const])
  end

  def initialize (value)
    @value = value.is_a?(Integer) ? value : Atom.const_missing(value)
  end

  def ok?
    self == Success
  end

  def == (value)
    to_i == value || to_sym == value
  end

  def hash
    @value.hash
  end

  def to_sym
    Status.to_hash.key(@value)
  end

  def to_i
    @value
  end; alias to_ffi to_i

  def inspect
    to_sym.to_s
  end
end

end
