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

class X11::C::XWindowAttributes < FFI::Struct
  layout \
    :x,                     :int,
    :y,                     :int,
    :width,                 :int,
    :height,                :int,
    :border_width,          :int,
    :depth,                 :int,
    :visual,                :pointer,
    :root,                  :Window,
    :class,                 :int,
    :bit_gravity,           :int,
    :win_gravity,           :int,
    :backing_store,         :int,
    :backing_planes,        :ulong,
    :backing_pixel,         :ulong,
    :save_under,            :Bool,
    :colormap,              :Colormap,
    :map_installed,         :Bool,
    :map_state,             :int,
    :all_event_masks,       :long,
    :your_event_masks,      :long,
    :do_not_propagate_mask, :long,
    :override_redirect,     :Bool,
    :screen,                :pointer
end
