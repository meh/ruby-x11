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
	def self.from (pointer, options={})
		Display.new(pointer, options.merge(:finalizer => false))
	end

  attr_reader :options

  def initialize (*args)
    name, options = if args.first.is_a?(Hash)
      [nil, args.first]
    else
      args
    end

    @display = if name.is_a?(FFI::Pointer)
			name
		elsif name.is_a?(C::Display)
			name.pointer
		else
			X11::C::XOpenDisplay(name)
		end.typecast(C::Display)

    if @display.pointer.null?
      raise ArgumentError, "could not connect to display #{name}"
    end

    @options = {
      :autoflush => true
    }.merge(options || {})

		unless @options[:finalizer] == false
	    ObjectSpace.define_finalizer self, self.class.finalizer(@display)
		end
  end

  def self.finalizer (display)
    proc {
      C::XCloseDisplay(display)
    }
  end

  C::Display.layout.members.each_with_index {|name, index|
    define_method name do
      @display[name]
    end
  }

  def flush
    return unless options[:autoflush]
    
    flush!
  end

  def flush!
    C::XFlush(to_ffi)
  end

  def screen (which)
    Screen.new(self, @display[:screens] + (which * C::Screen.size))
  end

  def default_screen
    screen(@display[:default_screen])
  end

  def screens
    Enumerator.new {
      (0 ... @display[:nscreens]).map {|i|
        yield screen(i)
      }
    }
  end

  [:root_window, :width, :height].each {|name|
    define_method name do
      default_screen.__send__ name
    end
  }

  def grab_pointer (*args)
    default_screen.root_window.grab_pointer(*args)
  end

  def ungrab_pointer (time=0)
    C::XUngrabPointer(to_ffi, time)
  end

  def keysym_to_keycode (keysym)
    C::XKeysymToKeycode(to_ffi, keysym)
  end

  def allow_events (mode, time=0)
    C::XAllowEvents(to_ffi, mode, time)
  end

  def check_typed_event (event)
    event = Event.index(event)
    ev    = FFI::MemoryPointer.new(C::XEvent)

    C::XCheckTypedEvent(to_ffi, event, ev) or return

    Event.new(ev)
  end

  def next_event
    event = FFI::MemoryPointer.new(C::XEvent)

    C::XNextEvent(to_ffi, event)

    Event.new(event)
  end

  def each_event
    loop {
      next_event.tap {|ev|
        yield ev if block_given?
      }
    }
  end

  def close
    C::XCloseDisplay(to_ffi)
  end

  def to_ffi
    @display.pointer
  end
end

end
