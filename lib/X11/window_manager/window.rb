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

class Window < Drawable
  def resource
    Struct.new(:name, :class).new(*properties[:WM_CLASS].value)
  end

  def title
    properties[:_NET_WM_VISIBLE_NAME].value.first rescue
    properties[:_NET_WM_NAME].value.first rescue
    properties[:WM_NAME].value.first rescue
    nil
  end

  def desktop
    begin
      index = properties[:_NET_WM_DESKTOP].value.first

      return true if index == 0xFFFFFFFF

      WindowManager.new(display).desktops[index]
    rescue
      WindowManager::Supports.raise :_NET_WM_DESKTOP
    end
  end

  def types
    begin
      properties[:_NET_WM_WINDOW_TYPE].value.map {|type|
        type.to_s[/[^_]*$/].to_sym
      }
    rescue
      WindowManager::Supports.raise :_NET_WM_WINDOW_TYPE
    end
  end

  def states
    begin
      properties[:_NET_WM_WINDOW_STATE].value.map {|type|
        type.to_s[/[^_]*$/].to_sym
      }
    rescue
      WindowManager::Supports.raise :_NET_WM_WINDOW_STATE
    end
  end

  def allowed_actions
    begin
      properties[:_NET_WM_ALLOWED_ACTIONS].value.map {|type|
        type.to_s[/[^_]*$/].to_sym
      }
    rescue
      WindowManager::Supports.raise :_NET_WM_USER_TIME
    end
  end

  def pid
    begin
      properties[:_NET_WM_PID].value.first
    rescue
      WindowManager::Supports.raise :_NET_WM_PID
    end
  end

  def last_action_at
    begin
      Time.at properties[:_NET_WM_USER_TIME].value.first
    rescue
      WindowManager::Supports.raise :_NET_WM_USER_TIME
    end
  end
end

end
