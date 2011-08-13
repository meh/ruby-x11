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

module X11

module Mask
  Event = Bitmap.new(
    :NoEvent              => (0 << 0),
    :KeyPress             => (1 << 0),
    :KeyRelease           => (1 << 1),
    :ButtonPress          => (1 << 2),
    :ButtonRelease        => (1 << 3),
    :EnterWindow          => (1 << 4),
    :LeaveWindow          => (1 << 5),
    :PointerMotion        => (1 << 6),
    :PointerMotionHint    => (1 << 7),
    :Button1Motion        => (1 << 8),
    :Button2Motion        => (1 << 9),
    :Button3Motion        => (1 << 10),
    :Button4Motion        => (1 << 11),
    :Button5Motion        => (1 << 12),
    :ButtonMotion         => (1 << 13),
    :KeymapState          => (1 << 14),
    :Exposure             => (1 << 15),
    :VisibilityChange     => (1 << 16),
    :StructureNotify      => (1 << 17),
    :ResizeRedirect       => (1 << 18),
    :SubstructureNotify   => (1 << 19),
    :SubstructureRedirect => (1 << 20),
    :FocusChange          => (1 << 21),
    :PropertyChange       => (1 << 22),
    :ColormapChange       => (1 << 23),
    :OwnerGrabButton      => (1 << 24)
  )

  Key = Bitmap.new(
    :Shift   => (1 << 0),
    :Lock    => (1 << 1),
    :Control => (1 << 2),
    :Mod1    => (1 << 3),
    :Mod2    => (1 << 4),
    :Mod3    => (1 << 5),
    :Mod4    => (1 << 6),
    :Mod5    => (1 << 7)
  )

  Hints = Bitmap.new(
    :Input        => (1 << 0),
    :State        => (1 << 1),
    :IconPixmap   => (1 << 2),
    :IconWindow   => (1 << 3),
    :IconPosition => (1 << 4),
    :IconMask     => (1 << 5),
    :WindowGroup  => (1 << 6),
    :Urgency      => (1 << 8)
  )

  GC = Bitmap.new(
    :Function          => (1L<<0)
    :PlaneMask         => (1L<<1)
    :Foreground        => (1L<<2)
    :Background        => (1L<<3)
    :LineWidth         => (1L<<4)
    :LineStyle         => (1L<<5)
    :CapStyle          => (1L<<6)
    :JoinStyle         => (1L<<7)
    :FillStyle         => (1L<<8)
    :FillRule          => (1L<<9)
    :Tile              => (1L<<10)
    :Stipple           => (1L<<11)
    :TileStipXOrigin   => (1L<<12)
    :TileStipYOrigin   => (1L<<13)
    :Font              => (1L<<14)
    :SubwindowMode     => (1L<<15)
    :GraphicsExposures => (1L<<16)
    :ClipXOrigin       => (1L<<17)
    :ClipYOrigin       => (1L<<18)
    :ClipMask          => (1L<<19)
    :DashOffset        => (1L<<20)
    :DashList          => (1L<<21)
    :ArcMode           => (1L<<22)
  )
end

end
