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

require 'X11/X'
require 'X11/Xdefs'

module FFI
	typedef :XID, :RROutput
	typedef :XID, :RRCrtc
	typedef :XID, :RRMode

	typedef :ulong, :XRRModeFlags
end

require 'X11/extensions/Xrandr/c/type/screen_size'
require 'X11/extensions/Xrandr/c/type/mode_info'
require 'X11/extensions/Xrandr/c/type/screen_resources'
require 'X11/extensions/Xrandr/c/type/output_info'
require 'X11/extensions/Xrandr/c/type/property_info'
require 'X11/extensions/Xrandr/c/type/crtc_info'
require 'X11/extensions/Xrandr/c/type/crtc_gamma'
require 'X11/extensions/Xrandr/c/type/crtc_transform_attributes'
require 'X11/extensions/Xrandr/c/type/panning'
