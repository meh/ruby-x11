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

require 'X11/window_manager/desktops/desktop'

module X11; class WindowManager

class Desktops
  include ForwardTo

  attr_reader :window_manager
  forward_to  :to_a

  alias wm window_manager

  def initialize (window_manager)
    @window_manager = window_manager
  end

  def to_a
    length   = wm.root.properties[:_NET_NUMBER_OF_DESKTOPS].value.first rescue nil
    roots    = wm.root.properties[:_NET_VIRTUAL_ROOTS].value rescue []
    desktops = wm.root.properties[:_NET_DESKTOP_NAMES].value.each_with_index.map {|name, index|
      Desktop.new(self, name, index, roots[index])
    } rescue []

    return desktops if length.nil? || desktops.length == length

    if length > desktops.length
      (desktops.length ... length).each {|index|
        desktops.push Desktop.new(self, nil, index, roots[index])
      }
    else
      desktops.pop(desktops.length - length)
    end

    desktops
  end

  def current
    begin
      self[wm.root.properties[:_NET_CURRENT_DESKTOP].value.first]
    rescue
      Supports.raise :_NET_CURRENT_DESKTOP
    end
  end

  def showing?
    begin
      wm.root.properties[:_NET_SHOWING_DESKTOP].value.first == 1
    rescue
      Supports.raise :_NET_SHOWING_DESKTOP
    end
  end
end

end; end
