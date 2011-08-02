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

class X11::C::XEvent < FFI::Union
  layout \
    :type,              :int,
    :xany,              X11::C::XAnyEvent,
    :xkey,              X11::C::XKeyEvent,
    :xbutton,           X11::C::XButtonEvent,
    :xmotion,           X11::C::XMotionEvent,
    :xcrossing,         X11::C::XCrossingEvent,
    :xfocus,            X11::C::XFocusChangeEvent,
    :xexpose,           X11::C::XExposeEvent,
    :xgraphicsexpose,   X11::C::XGraphicsExposeEvent,
    :xnoexpose,         X11::C::XNoExposeEvent,
    :xvisibility,       X11::C::XVisibilityEvent,
    :xcreatewindow,     X11::C::XCreateWindowEvent,
    :xdestroywindow,    X11::C::XDestroyWindowEvent,
    :xunmap,            X11::C::XUnmapEvent,
    :xmap,              X11::C::XMapEvent,
    :xmaprequest,       X11::C::XMapRequestEvent,
    :xreparent,         X11::C::XReparentEvent,
    :xconfigure,        X11::C::XConfigureEvent,
    :xgravity,          X11::C::XGravityEvent,
    :xresizerequest,    X11::C::XResizeRequestEvent,
    :xconfigurerequest, X11::C::XConfigureRequestEvent,
    :xcirculate,        X11::C::XCirculateEvent,
    :xcirculaterequest, X11::C::XCirculateRequestEvent,
    :xproperty,         X11::C::XPropertyEvent,
    :xselectionclear,   X11::C::XSelectionClearEvent,
    :xselectionrequest, X11::C::XSelectionRequestEvent,
    :xselection,        X11::C::XSelectionEvent,
    :xcolormap,         X11::C::XColormapEvent,
    :xclient,           X11::C::XClientMessageEvent,
    :xmapping,          X11::C::XMappingEvent,
    :xerror,            X11::C::XErrorEvent,
    :xkeymap,           X11::C::XKeymapEvent,
    :xgeneric,          X11::C::XGenericEvent,
    :xcookie,           X11::C::XGenericEventCookie,
    :pad,               [:long, 24]
end

