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

module X11

class Error < Exception
  def self.from (event)
    X11::const_get(Status.new(event[:error_code]).to_sym).new(event)
  end

  def self.raise (klass, message=nil)
    @error = message ? klass.new(message) : klass
  end

  def self.pop
    @error.tap {
      @error = nil
    }
  end

  attr_reader :type, :display, :resource, :serial, :error, :request, :minor

  def initialize (event=nil)
    return super(self.class.name[/\w+$/]) unless event

    @type     = event[:type]
    @display  = X11::Display.new(event[:display])
    @resource = event[:resourceid]
    @serial   = event[:serial]
    @error    = event[:error_code]
    @request  = event[:request_code]
    @minor    = event[:minor_code]

    FFI::MemoryPointer.new(512).tap {|string|
      C::XGetErrorText(@display.to_ffi, @error, string, string.size)

      super(string.typecast(:string))
    }
  end

  def to_sym
    self.class.name[/\w+$/].to_sym
  end

  def inspect
    "#<#{to_sym}: 0x#{resource.to_s(16)} #{request}:#{error}.#{minor}>"
  end
end

BadRequest        = Class.new(Error)
BadValue          = Class.new(Error)
BadWindow         = Class.new(Error)
BadPixmap         = Class.new(Error)
BadAtom           = Class.new(Error)
BadCursor         = Class.new(Error)
BadFont           = Class.new(Error)
BadMatch          = Class.new(Error)
BadDrawable       = Class.new(Error)
BadAccess         = Class.new(Error)
BadAlloc          = Class.new(Error)
BadColor          = Class.new(Error)
BadGC             = Class.new(Error)
BadIDChoice       = Class.new(Error)
BadName           = Class.new(Error)
BadLength         = Class.new(Error)
BadImplementation = Class.new(Error)

end

# NOTE: this is an ugly hack while we wait for FFI.raise
module X11; module C
  attach_function :XSetErrorHandler, [:pointer], :pointer
  attach_function :XSetIOErrorHandler, [:pointer], :pointer
  attach_function :XGetErrorText, [:pointer, :int, :pointer, :int], :int

  refine_singleton_method :attach_function do |old, name, *rest|
    old.call(name, *rest)

    refine_singleton_method name do |old, *args, &block|
      old.call(*args, &block).tap {
        if error = X11::Error.pop
          raise error
        end
      }
    end
  end

  XSetErrorHandler(X11::ErrorHandler = FFI::Function.new(:int, [:pointer, :pointer]) {|display, event|
    X11::Error.raise Error.from(C::XErrorEvent.new(event)); 1
  })

  XSetIOErrorHandler(X11::IOErrorHandler = FFI::Function.new(:int, [:pointer]) {|display|
    X11::Error.raise IOError, 'fatal X IO error'; 1
  })
end; end
