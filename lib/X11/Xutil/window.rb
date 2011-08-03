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

class Window
  def title
    text = FFI::MemoryPointer.new :pointer

    C::XFetchName(display.to_ffi, to_ffi, text)

    return if text.typecast(:pointer).null?

    text.typecast(:pointer).typecast(:string).tap {
      C::XFree(text.typecast(:pointer))
    }
  end; alias WM_NAME title

  def class_hint
    return if (hint = C::XAllocClassHint()).null?

    if C::XGetClassHint(display.to_ffi, to_ffi, hint).zero?
      C::XFree(hint)

      return
    end

    C::XClassHint.new(hint).tap {|c|
      break :name => c[:res_name], :class => c[:res_class]
    }.tap {
      C::XFree(hint)
    }
  end

  def name
    class_hint.tap {|hint|
      break hint[:name] if hint
    }
  end

  def klass
    class_hint.tap {|hint|
      break hint[:class] if hint
    }
  end; alias WM_CLASS klass
end

end
