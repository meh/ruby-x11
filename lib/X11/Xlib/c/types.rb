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

require 'X11/X'
require 'X11/Xdefs'

require 'X11/Xlib/c/type/display'
require 'X11/Xlib/c/type/gc'
require 'X11/Xlib/c/type/screen'
require 'X11/Xlib/c/type/window_attributes'
require 'X11/Xlib/c/type/visual'

require 'X11/Xlib/c/type/any_event'
require 'X11/Xlib/c/type/key_event'
require 'X11/Xlib/c/type/button_event'
require 'X11/Xlib/c/type/motion_event'
require 'X11/Xlib/c/type/crossing_event'
require 'X11/Xlib/c/type/focus_change_event'
require 'X11/Xlib/c/type/expose_event'
require 'X11/Xlib/c/type/graphics_expose_event'
require 'X11/Xlib/c/type/no_expose_event'
require 'X11/Xlib/c/type/visibility_event'
require 'X11/Xlib/c/type/create_window_event'
require 'X11/Xlib/c/type/destroy_window_event'
require 'X11/Xlib/c/type/unmap_event'
require 'X11/Xlib/c/type/map_event'
require 'X11/Xlib/c/type/map_request_event'
require 'X11/Xlib/c/type/reparent_event'
require 'X11/Xlib/c/type/configure_event'
require 'X11/Xlib/c/type/gravity_event'
require 'X11/Xlib/c/type/resize_request_event'
require 'X11/Xlib/c/type/configure_request_event'
require 'X11/Xlib/c/type/circulate_event'
require 'X11/Xlib/c/type/circulate_request_event'
require 'X11/Xlib/c/type/property_event'
require 'X11/Xlib/c/type/selection_clear_event'
require 'X11/Xlib/c/type/selection_request_event'
require 'X11/Xlib/c/type/selection_event'
require 'X11/Xlib/c/type/colormap_event'
require 'X11/Xlib/c/type/client_message_event'
require 'X11/Xlib/c/type/mapping_event'
require 'X11/Xlib/c/type/error_event'
require 'X11/Xlib/c/type/keymap_event'
require 'X11/Xlib/c/type/generic_event'
require 'X11/Xlib/c/type/generic_event_cookie'
require 'X11/Xlib/c/type/event'
