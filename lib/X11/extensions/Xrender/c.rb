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

module FFI
  typedef :int, :XFixed
  typedef :double, :XDouble
end

require 'X11/extensions/Xrender/c/type/render_direct_format'
require 'X11/extensions/Xrender/c/type/render_pict_format'
require 'X11/extensions/Xrender/c/type/render_picture_attributes'
require 'X11/extensions/Xrender/c/type/render_color'
require 'X11/extensions/Xrender/c/type/glyph_info'
require 'X11/extensions/Xrender/c/type/glyph_elt8'
require 'X11/extensions/Xrender/c/type/glyph_elt16'
require 'X11/extensions/Xrender/c/type/glyph_elt32'
require 'X11/extensions/Xrender/c/type/point_double'
require 'X11/extensions/Xrender/c/type/point_fixed'
require 'X11/extensions/Xrender/c/type/line_fixed'
require 'X11/extensions/Xrender/c/type/triangle'
require 'X11/extensions/Xrender/c/type/circle'
require 'X11/extensions/Xrender/c/type/trapezoid'
require 'X11/extensions/Xrender/c/type/transform'
require 'X11/extensions/Xrender/c/type/filters'
require 'X11/extensions/Xrender/c/type/index_value'
require 'X11/extensions/Xrender/c/type/anim_cursor'
require 'X11/extensions/Xrender/c/type/span_fix'
require 'X11/extensions/Xrender/c/type/trap'
require 'X11/extensions/Xrender/c/type/linear_gradient'
require 'X11/extensions/Xrender/c/type/radial_gradient'
require 'X11/extensions/Xrender/c/type/conical_gradient'
