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

module X11; module C

ffi_lib_add 'Xxf86vm'

attach_function :XF86VidModeQueryVersion, [:pointer, :pointer, :pointer], :Bool
attach_function :XF86VidModeQueryExtension, [:pointer, :pointer, :pointer], :Bool
attach_function :XF86VidModeSetClientVersion, [:pointer], :Bool

attach_function :XF86VidModeGetModeLine, [:pointer, :int, :pointer, :pointer], :Bool
attach_function :XF86VidModeGetAllModeLines, [:pointer, :int, :pointer, :pointer], :Bool
attach_function :XF86VidModeAddModeLine, [:pointer, :int, :pointer, :pointer], :Bool
attach_function :XF86VidModeDeleteModeLine, [:pointer, :int, :pointer], :Bool
attach_function :XF86VidModeModModeLine, [:pointer, :int, :pointer], :Bool
attach_function :XF86VidModeValidateModeLine, [:pointer, :int, :pointer], :Status
attach_function :XF86VidModeSwitchMode, [:pointer, :int, :int], :Bool
attach_function :XF86VidModeSwitchToMode, [:pointer, :int, :pointer], :Bool
attach_function :XF86VidModeLockModeSwitch, [:pointer, :int, :int], :Bool

attach_function :XF86VidModeGetMonitor, [:pointer, :int, :pointer], :Bool
attach_function :XF86VidModeGetViewPort, [:pointer, :int, :pointer, :pointer], :Bool
attach_function :XF86VidModeSetViewPort, [:pointer, :int, :int, :int], :Bool
attach_function :XF86VidModeGetDotClocks, [:pointer, :int, :pointer, :pointer, :pointer, :pointer], :Bool

attach_function :XF86VidModeGetGamma, [:pointer, :int, :pointer], :Bool
attach_function :XF86VidModeSetGamma, [:pointer, :int, :pointer], :Bool
attach_function :XF86VidModeSetGammaRamp, [:pointer, :int, :int, :pointer, :pointer, :pointer], :Bool
attach_function :XF86VidModeGetGammaRamp, [:pointer, :int, :int, :pointer, :pointer, :pointer], :Bool
attach_function :XF86VidModeGetGammaRampSize, [:pointer, :int, :pointer], :Bool
attach_function :XF86VidModeGetPermissions, [:pointer, :int, :pointer], :Bool

end; end
