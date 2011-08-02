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

module X11

class Display
  def initialize (name=nil)
    pointer  = (name.is_a?(String) or !name) ? X11::C::XOpenDisplay(name) : name
    @display = pointer.is_a?(X11::C::Display) ? pointer : pointer.typecast(X11::C::Display)
  end

  def ungrab_pointer (time=0)
    C::XUngrabPointer(to_c, time)
  end

  def keysym_to_keycode (keysym)
    C::XKeysymToKeycode(to_c, keysym)
  end

  def check_typed_event (event)
    event = Event.index(event)
    ev    = FFI::MemoryPointer.new(C::XEvent)

    C::XCheckTypedEvent(to_c, event, ev) or return

    Event.new(ev)
  end

  def screen (which)
    Screen.new(self, @display[:screens] + (which * C::Screen.size))
  end

  def default_screen
    screen(@display[:default_screen])
  end

  def screens
    (0 ... @display[:nscreens]).map {|i|
      screen(i)
    }
  end

  def next_event
    ev = FFI::MemoryPointer.new(C::XEvent)

    C::XNextEvent(to_c, ev)

    Event.new(ev)
  end

  def each_event
    loop {
      next_event.tap {|ev|
        yield ev if block_given?
      }
    }
  end

  def close
    C::XCloseDisplay(to_c)
  end

  def to_c
    @display.pointer
  end
end

end
