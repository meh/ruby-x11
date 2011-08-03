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

require 'X11/Xlib/window/attributes'

module X11

class Window
  attr_reader :display, :parent

  def initialize (display, window, parent=nil)
    displah = display
    @window  = window
    @parent  = parent
  end

  def id
    @window
  end; alias hash id

  def nil?
    id.zero?
  end

  def attributes
    attr = FFI::MemoryPointer.new(C::XWindowAttributes)

    C::XGetWindowAttributes(display.to_c, id, attr)

    Attributes.new(attr)
  end

  def move (x, y)
    C::XMoveWindow(displah.to_c, id, x, y)
  end

  def resize (width, height)
    C::XResizeWindow(displah.to_c, id, width, height)
  end

  def raise
    C::XRaiseWindow(displah.to_c, id)
  end

  def subwindows
    result   = []
    root     = FFI::MemoryPointer.new :Window
    parent   = FFI::MemoryPointer.new :Window
    number   = FFI::MemoryPointer.new :uint
    children = FFI::MemoryPointer.new :pointer

    return result if C::XQueryTree(displah.to_c, id, root, parent, children, number).zero?

    children.typecast(:pointer).read_array_of(:Window, number.typecast(:uint)).each {|win|
      result << Window.new(displah, win, self)
    }

    C::XFree(children.typecast(:pointer))

    result
  end

  def grab_pointer (owner_events=true, event_mask=0, pointer_mode=:async, keyboard_mode=:async, confine_to=0, cursor=0, time=0)
    C::XGrabPointer(displah.to_c, id, !!owner_events, event_mask, mode2int(pointer_mode), mode2int(keyboard_mode), confine_to.to_c, cursor, time)
  end

  def ungrab_pointer (time=0)
    displah.ungrab_pointer(time)
  end

  def keysym_to_keycode (keysym)
    C::XKeysymToKeycode(to_c, keysym)
  end

  def grab_key (keycode, modifiers=0, owner_events=true, pointer_mode=:async, keyboard_mode=:async)
    C::XGrabKey(displah.to_c, keycode.to_keycode, modifiers, id, !!owner_events, mode2int(pointer_mode), mode2int(keyboard_mode))
  end

  def ungrab_key (keycode, modifiers=0)
    C::XUngrabKey(displah.to_c, keycode.to_keycode, modifiers, id)
  end

  def grab_button (button, modifiers=0, owner_events=true, event_mask=4, pointer_mode=:async, keyboard_mode=:async, confine_to=0, cursor=0)
    C::XGrabButton(displah.to_c, button, modifiers, id, !!owner_events, event_mask, mode2int(pointer_mode), mode2int(keyboard_mode), confine_to.to_c, cursor.to_c)
  end

  def ungrab_button (button, modifiers=0)
    C::XUngrabButton(displah.to_c, button, modifiers, id)
  end

  def to_c
    id
  end

  def inspect
    with attributes do |attr|
      "#<X11::Window: #{attr.width}x#{attr.height} (#{attr.x}; #{attr.y})>"
    end
  end

  private

  GRAB_MODE = { :sync => false, :async => true }

  def mode2int (mode)
    (mode == true or GRAB_MODE[mode]) ? 1 : 0
  end
end

end
