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

X11::Events = []

require 'X11/Xlib/event/helper'

# NOTE: the require order is VITAL
require 'X11/Xlib/event/any'
require 'X11/Xlib/event/key_press'
require 'X11/Xlib/event/key_release'
require 'X11/Xlib/event/button_press'
require 'X11/Xlib/event/button_release'
require 'X11/Xlib/event/motion_notify'
require 'X11/Xlib/event/enter_notify'
require 'X11/Xlib/event/leave_notify'
require 'X11/Xlib/event/focus_in'
require 'X11/Xlib/event/focus_out'
require 'X11/Xlib/event/keymap_notify'
require 'X11/Xlib/event/expose'
require 'X11/Xlib/event/graphics_expose'
require 'X11/Xlib/event/no_expose'
require 'X11/Xlib/event/visibility_notify'
require 'X11/Xlib/event/create_notify'
require 'X11/Xlib/event/destroy_notify'
require 'X11/Xlib/event/unmap_notify'
require 'X11/Xlib/event/map_notify'
require 'X11/Xlib/event/map_request'
require 'X11/Xlib/event/reparent_notify'
require 'X11/Xlib/event/configure_notify'
require 'X11/Xlib/event/configure_request'
require 'X11/Xlib/event/gravity_notify'
require 'X11/Xlib/event/resize_request'
require 'X11/Xlib/event/circulate_notify'
require 'X11/Xlib/event/circulate_request'
require 'X11/Xlib/event/property_notify'
require 'X11/Xlib/event/selection_clear'
require 'X11/Xlib/event/selection_request'
require 'X11/Xlib/event/selection_notify'
require 'X11/Xlib/event/colormap_notify'
require 'X11/Xlib/event/client_message'
require 'X11/Xlib/event/mapping_notify'
require 'X11/Xlib/event/generic_event'
