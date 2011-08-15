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

module X11; class Window < Drawable

class Attributes
  attr_reader :window

  def initialize (window, attributes)
    @window     = window
    @attributes = attributes.is_a?(C::XWindowAttributes) ? attributes : attributes.typecast(C::XWindowAttributes)
  end

  C::XWindowAttributes.layout.members.each_with_index {|name, index|
    next if respond_to? name

    define_method name do
      @attributes[name]
    end
  }

  def input_only?
    @attributes[:class] == 2
  end

  def unmapped?
    @attributes[:map_state] == 0
  end

  def unviewable?
    @attributes[:map_state] == 1
  end

  def viewable?
    @attributes[:map_state] == 2
  end

  def override_redirect?
    @attributes[:override_redirect]
  end

  def save_under?
    @attributes[:save_under]
  end

  def map_installed?
    @attributes[:map_installed]
  end

  def root
    Window.new(window.display, @attributes[:root])
  end

  def visual
    Visual.new(window.display, @attributes[:visual])
  end

  def screen
    Screen.new(window.display, @attributes[:screen])
  end
end

end; end
