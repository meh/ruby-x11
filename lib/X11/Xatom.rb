#--
# Copyleft meh. [http://meh.paranoid.pk | meh@paranoici.org]
# 
# Redistribution and use in source and binary forms, with or without modification, are
# permitted provided that the following conditions are met:
# 
#    * 1. Redistributions of source code must retain the above copyright notice, this list of
#       conditions and the following disclaimer.
# 
#    * 2. Redistributions in binary form must reproduce the above copyright notice, this list
#       of conditions and the following disclaimer in the documentation and/or other materials
#       provided with the distribution.
# 
# THIS SOFTWARE IS PROVIDED BY <COPYRIGHT HOLDER> ''AS IS'' AND ANY EXPRESS OR IMPLIED
# WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
# FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> OR
# CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
# SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION HOWEVER CAUSED AND ON
# ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
# NEGLIGENCE OR OTHERWISE ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
# ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
# 
# The views and conclusions contained in the software and documentation are those of the
# authors and should not be interpreted as representing official policies, either expressed
# or implied.
#++

require 'X11/extensions'

module X11

class Atom
  @atoms = {
    :PRIMARY             => 1,
    :SECONDARY           => 2,
    :ARC                 => 3,
    :ATOM                => 4,
    :BITMAP              => 5,
    :CARDINAL            => 6,
    :COLORMAP            => 7,
    :CURSOR              => 8,
    :CUT_BUFFER0         => 9,
    :CUT_BUFFER1         => 10,
    :CUT_BUFFER2         => 11,
    :CUT_BUFFER3         => 12,
    :CUT_BUFFER4         => 13,
    :CUT_BUFFER5         => 14,
    :CUT_BUFFER6         => 15,
    :CUT_BUFFER7         => 16,
    :DRAWABLE            => 17,
    :FONT                => 18,
    :INTEGER             => 19,
    :PIXMAP              => 20,
    :POINT               => 21,
    :RECTANGLE           => 22,
    :RESOURCE_MANAGER    => 23,
    :RGB_COLOR_MAP       => 24,
    :RGB_BEST_MAP        => 25,
    :RGB_BLUE_MAP        => 26,
    :RGB_DEFAULT_MAP     => 27,
    :RGB_GRAY_MAP        => 28,
    :RGB_GREEN_MAP       => 29,
    :RGB_RED_MAP         => 30,
    :STRING              => 31,
    :VISUALID            => 32,
    :WINDOW              => 33,
    :WM_COMMAND          => 34,
    :WM_HINTS            => 35,
    :WM_CLIENT_MACHINE   => 36,
    :WM_ICON_NAME        => 37,
    :WM_ICON_SIZE        => 38,
    :WM_NAME             => 39,
    :WM_NORMAL_HINTS     => 40,
    :WM_SIZE_HINTS       => 41,
    :WM_ZOOM_HINTS       => 42,
    :MIN_SPACE           => 43,
    :NORM_SPACE          => 44,
    :MAX_SPACE           => 45,
    :END_SPACE           => 46,
    :SUPERSCRIPT_X       => 47,
    :SUPERSCRIPT_Y       => 48,
    :SUBSCRIPT_X         => 49,
    :SUBSCRIPT_Y         => 50,
    :UNDERLINE_POSITION  => 51,
    :UNDERLINE_THICKNESS => 52,
    :STRIKEOUT_ASCENT    => 53,
    :STRIKEOUT_DESCENT   => 54,
    :ITALIC_ANGLE        => 55,
    :X_HEIGHT            => 56,
    :QUAD_WIDTH          => 57,
    :WEIGHT              => 58,
    :POINT_SIZE          => 59,
    :RESOLUTION          => 60,
    :COPYRIGHT           => 61,
    :NOTICE              => 62,
    :FONT_NAME           => 63,
    :FAMILY_NAME         => 64,
    :FULL_NAME           => 65,
    :CAP_HEIGHT          => 66,
    :WM_CLASS            => 67,
    :WM_TRANSIENT_FOR    => 68,

    :LAST_PREDEFINED => 68
  }

  def self.to_hash
    @atoms
  end

  def self.const_missing (const)
    Atom.new(to_hash.find {|name, value|
      name.downcase == const.downcase
    }.last)
  end

	def self.method_missing (id, *)
		const_missing(id)
	end

  def initialize (value)
    @value = value.is_a?(Integer) ? value : Atom.const_missing(value)
  end

  def to_sym
    Atom.to_hash.key(@value)
  end

  def to_i
    @value
  end; alias to_ffi to_i

	def inspect
		to_sym.to_s
	end
end

end

require 'X11/Xatom/c'
