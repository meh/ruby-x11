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

class X11::C::Display < FFI::Struct
  layout \
    :ext_data,            :pointer,
    :private1,            :pointer,
    :fd,                  :int,
    :private2,            :int,
    :proto_major_version, :int,
    :proto_minor_version, :int,
    :vendor,              :string,
    :private3,            :XID,
    :private4,            :XID,
    :private5,            :XID,
    :private6,            :int,
    :resource_alloc,      :pointer,
    :byte_order,          :int,
    :bitmap_unit,         :int,
    :bitmap_pad,          :int,
    :bitmap_bit_order,    :int,
    :nformats,            :int,
    :pixmap_format,       :pointer,
    :private8,            :int,
    :release,             :int,
    :private9,            :pointer,
    :private10,           :pointer,
    :qlen,                :int,
    :last_request_read,   :ulong,
    :request,             :ulong,
    :private11,           :pointer,
    :private12,           :pointer,
    :private13,           :pointer,
    :private14,           :pointer,
    :max_request_size,    :uint,
    :db,                  :pointer,
    :private15,           :pointer,
    :display_name,        :string,
    :default_screen,      :int,
    :nscreens,            :int,
    :screens,             :pointer,
    :motion_buffer,       :ulong,
    :private16,           :ulong,
    :min_keycode,         :int,
    :max_keycode,         :int,
    :private17,           :pointer,
    :private18,           :pointer,
    :private19,           :int,
    :xdefaults,           :string
end
