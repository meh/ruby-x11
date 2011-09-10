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

ffi_lib_add 'Xrandr'

attach_function :XRRQueryExtension, [:pointer, :pointer, :pointer], :Bool
attach_function :XRRQueryVersion, [:pointer, :pointer, :pointer], :Status

attach_function :XRRGetScreenInfo, [:pointer, :Window], :pointer
attach_function :XRRFreeScreenConfigInfo, [:pointer], :void
attach_function :XRRSetScreenConfig, [:pointer, :pointer, :Drawable, :int, :Rotation, :Time], :Status
attach_function :XRRSetScreenConfigAndRate, [:pointer, :pointer, :Drawable, :int, :Rotation, :short, :Time], :Status

attach_function :XRRConfigRotations, [:pointer, :pointer], :Rotation
attach_function :XRRConfigTimes, [:pointer, :pointer], :Time
attach_function :XRRConfigSizes, [:pointer, :pointer], :pointer
attach_function :XRRConfigRates, [:pointer, :int, :pointer], :pointer

attach_function :XRRConfigCurrentConfiguration, [:pointer, :pointer], :SizeID
attach_function :XRRConfigCurrentRate, [:pointer], :short

attach_function :XRRRootToScreen, [:pointer, :Window], :int

attach_function :XRRSelectInput, [:pointer, :Window, :int], :void

attach_function :XRRRotations, [:pointer, :int, :pointer], :Rotation
attach_function :XRRSizes, [:pointer, :int, :pointer], :pointer
attach_function :XRRRates, [:pointer, :int, :int, :pointer], :pointer
attach_function :XRRTimes, [:pointer, :int, :pointer], :Time

# 1.2 additions
attach_function :XRRGetScreenSizeRange, [:pointer, :Window, :pointer, :pointer, :pointer, :pointer], :Status
attach_function :XRRSetScreenSize, [:pointer, :Window, :int, :int, :int, :int], :void

attach_function :XRRGetScreenResources, [:pointer, :Window], :pointer
attach_function :XRRFreeScreenResources, [:pointer], :void

attach_function :XRRGetOutputInfo, [:pointer, :pointer, :RROutput], :pointer
attach_function :XRRFreeOutputInfo, [:pointer], :void

attach_function :XRRListOutputProperties, [:pointer, :RROutput, :pointer], :pointer
attach_function :XRRQueryOutputProperty, [:pointer, :RROutput, :Atom], :pointer
attach_function :XRRConfigureOutputProperty, [:pointer, :RROutput, :Atom, :Bool, :Bool, :int, :pointer], :void
attach_function :XRRChangeOutputProperty, [:pointer, :RROutput, :Atom, :Atom, :int, :int, :pointer, :int], :void
attach_function :XRRDeleteOutputProperty, [:pointer, :RROutput, :Atom], :void
attach_function :XRRGetOutputProperty, [:pointer, :RROutput, :Atom, :long, :long, :Bool, :Bool, :Atom, :pointer, :pointer, :pointer, :pointer, :pointer], :int

attach_function :XRRAllocModeInfo, [:pointer, :int], :pointer
attach_function :XRRCreateMode, [:pointer, :Window, :pointer], :RRMode
attach_function :XRRDestroyMode, [:pointer, :RRMode] :void
attach_function :XRRAddOutputMode, [:pointer, :RROutput, :RRMode], :void
attach_function :XRRDeleteOutputMode, [:pointer, :RROutput, :RRMode], :void
attach_function :XRRFreeModeInfo, [:pointer], :void

attach_function :XRRGetCrtcInfo, [:pointer, :poiter, :RRCrtc]
attach_function :XRRFreeCrtcInfo, [:pointer], :void
attach_function :XRRSetCrtcConfig, [:pointer, :poiner, :RRCrtc, :Time, :int, :int, :RRMode, :Rotation, :pointer, :int], :Status

attach_function :XRRGetCrtcGammaSize, [:pointer, :RRCrtc], :int
attach_function :XRRGetCrtcGamma, [:pointer, :RRCrtc], :pointer
attach_function :XRRAllocGamma, [:int], :pointer
attach_function :XRRSetCrtcGamma, [:pointer, :RRCrtc, :pointer], :void
attach_function :XRRFreeGamma, [:pointer], :void

# 1.3 additions
attach_function :XRRGetScreenResourcesCurrent, [:pointer, :Window], :pointer
attach_function :XRRUpdateConfiguration, [:pointer], :int

attach_function :XRRSetCrtcTransform, [:pointer, :RRCrtc, :pointer, :string, :pointer, :int], :void
attach_function :XRRGetCrtcTransform, [:pointer, :RRCrtc, :pointer], :Status

attach_function :XRRGetPanning, [:pointer, :pointer, :RRCrtc], :pointer
attach_function :XRRFreePanning, [:pointer], :void
attach_function :XRRSetPanning, [:pointer, :pointer, :RRCrtc, :pointer], :Status

attach_function :XRRSetOutputPrimary, [:pointer, :Window, :RROutput], :void
attach_function :XRRGetOutputPrimary, [:pointer, :Window], :RROutput

end; end
