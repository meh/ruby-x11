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

module X11; module C

attach_function :XFree, [:pointer], :int

attach_function :XOpenDisplay, [:string], :pointer
attach_function :XCloseDisplay, [:pointer], :int
attach_function :XFlush, [:pointer], :int
attach_function :XGetInputFocus, [:pointer, :pointer, :pointer], :int
attach_function :XSetInputFocus, [:pointer, :Window, :int, :Time], :int

attach_function :XGrabButton, [:pointer, :uint, :uint, :Window, :Bool, :uint, :int, :int, :Window, :Cursor], :int
attach_function :XGrabKey, [:pointer, :int, :uint, :Window, :Bool, :int, :int], :int
attach_function :XGrabKeyboard, [:pointer, :Window, :Bool, :int, :int, :Time], :int
attach_function :XGrabPointer, [:pointer, :Window, :Bool, :uint, :int, :int, :Window, :Cursor, :Time], :int
attach_function :XQueryPointer, [:pointer, :Window, :pointer, :pointer, :pointer, :pointer, :pointer, :pointer, :pointer], :Bool

attach_function :XUngrabButton, [:pointer, :uint, :uint, :Window], :int
attach_function :XUngrabKey, [:pointer, :int, :uint, :Window], :int
attach_function :XUngrabKeyboard, [:pointer, :Time], :int
attach_function :XUngrabPointer, [:pointer, :Time], :int

attach_function :XGetWindowAttributes, [:pointer, :Window, :pointer], :int
attach_function :XMoveResizeWindow, [:pointer, :Window, :int, :int, :uint, :uint], :int
attach_function :XMoveWindow, [:pointer, :Window, :int, :int], :int
attach_function :XResizeWindow, [:pointer, :Window, :uint, :uint], :int
attach_function :XRaiseWindow, [:pointer, :Window], :int
attach_function :XQueryTree, [:pointer, :Window, :pointer, :pointer, :pointer, :pointer], :Status
attach_function :XListProperties, [:pointer, :Window, :pointer], :pointer
attach_function :XGetWindowProperty, [:pointer, :Window, :Atom, :long, :long, :Bool, :Atom, :pointer, :pointer, :pointer, :pointer, :pointer], :Status

attach_function :XAllowEvents, [:pointer, :int, :Time], :int
attach_function :XNextEvent, [:pointer, :pointer], :int
attach_function :XMaskEvent, [:pointer, :long, :pointer], :int
attach_function :XCheckTypedEvent, [:pointer, :int, :pointer], :Bool
attach_function :XWindowEvent, [:pointer, :Window, :long, :pointer], :int

attach_function :XStringToKeysym, [:string], :KeySym
attach_function :XKeysymToString, [:KeySym], :string
attach_function :XKeysymToKeycode, [:pointer, :KeySym], :KeyCode

end; end
