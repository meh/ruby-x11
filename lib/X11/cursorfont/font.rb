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

module X11; module Cursor

class Font
	module Shapes
		@shapes = {
			:num_glyphs          => 154,
			:X_cursor            => 0,
			:arrow               => 2,
			:based_arrow_down    => 4,
			:based_arrow_up      => 6,
			:boat                => 8,
			:bogosity            => 10,
			:bottom_left_corner  => 12,
			:bottom_right_corner => 14,
			:bottom_side         => 16,
			:bottom_tee          => 18,
			:box_spiral          => 20,
			:center_ptr          => 22,
			:circle              => 24,
			:clock               => 26,
			:coffee_mug          => 28,
			:cross               => 30,
			:cross_reverse       => 32,
			:crosshair           => 34,
			:diamond_cross       => 36,
			:dot                 => 38,
			:dotbox              => 40,
			:double_arrow        => 42,
			:draft_large         => 44,
			:draft_small         => 46,
			:draped_box          => 48,
			:exchange            => 50,
			:fleur               => 52,
			:gobbler             => 54,
			:gumby               => 56,
			:hand1               => 58,
			:hand2               => 60,
			:heart               => 62,
			:icon                => 64,
			:iron_cross          => 66,
			:left_ptr            => 68,
			:left_side           => 70,
			:left_tee            => 72,
			:leftbutton          => 74,
			:ll_angle            => 76,
			:lr_angle            => 78,
			:man                 => 80,
			:middlebutton        => 82,
			:mouse               => 84,
			:pencil              => 86,
			:pirate              => 88,
			:plus                => 90,
			:question_arrow      => 92,
			:right_ptr           => 94,
			:right_side          => 96,
			:right_tee           => 98,
			:rightbutton         => 100,
			:rtl_logo            => 102,
			:sailboat            => 104,
			:sb_down_arrow       => 106,
			:sb_h_double_arrow   => 108,
			:sb_left_arrow       => 110,
			:sb_right_arrow      => 112,
			:sb_up_arrow         => 114,
			:sb_v_double_arrow   => 116,
			:shuttle             => 118,
			:sizing              => 120,
			:spider              => 122,
			:spraycan            => 124,
			:star                => 126,
			:target              => 128,
			:tcross              => 130,
			:top_left_arrow      => 132,
			:top_left_corner     => 134,
			:top_right_corner    => 136,
			:top_side            => 138,
			:top_tee             => 140,
			:trek                => 142,
			:ul_angle            => 144,
			:umbrella            => 146,
			:ur_angle            => 148,
			:watch               => 150,
			:xterm               => 152
		}

		def self.[] (name)
			if name.is_a?(Integer)
				@shapes.key(name)
			else
				@shapes[name.to_s.to_sym]
			end
		end

		def self.const_missing (name)
			@shapes[name]
		end

		def self.method_missing (name, *)
			@shapes[name]
		end
	end

	attr_reader :display

	def initialize (display, shape)
		@display = display
		@shape   = shape.is_a?(Integer) ? shape : Shapes[shape]
	end

	def to_s
		Shapes[@shape].to_s
	end

	def to_ffi
		C::XCreateFontCursor(display.to_ffi, @shape)
	end
end

end; end
