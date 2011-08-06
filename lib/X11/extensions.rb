#--
# Copyleft shura. [ shura1991@gmail.com ]
#
# This file is part of sysctl.
#
# sysctl is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published
# by the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# sysctl is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with sysctl. If not, see <http://www.gnu.org/licenses/>.
#++

require 'ffi' unless defined?(RUBY_ENGINE) && RUBY_ENGINE == 'rbx'
require 'memoized'
require 'refining'
require 'retarded'
require 'forwardable'
require 'ostruct'

module Kernel
  def with (*args)
    yield *args
  end

  def suppress_warnings
    exception = nil
    tmp, $VERBOSE = $VERBOSE, nil

    begin
      result = yield
    rescue Exception => e
      exception = e
    end

    $VERBOSE = tmp

    if exception
      raise exception
    else
      result
    end
  end
end

module FFI
  def self.sizeof (type)
    type = FFI.find_type(type) if type.is_a?(Symbol)

    if type.is_a?(Class) && (type.ancestors.member?(FFI::Struct) && !type.is_a?(FFI::ManagedStruct)) || type.is_a?(Type::Builtin)
      type.size
    elsif type.respond_to? :from_native
      type.native_type.size
    else
      raise ArgumentError, 'you have to pass a Struct, a Builtin type or a Symbol'
    end
  end

  module Library
    def ffi_lib_add (*names)
      ffi_lib *((begin
        ffi_libraries
      rescue Exception
        []
      end).map {|lib|
        lib.name
      } + names).compact.uniq.reject {|lib|
        lib == '[current process]'
      }
    end

    def has_function? (sym, libraries=nil)
      libraries ||= ffi_libraries

      libraries.any? {|lib|
        if lib.is_a?(DynamicLibrary)
          lib
        else
          DynamicLibrary.new(lib, 0)
        end.find_function(sym.to_s) rescue nil
      }
    end

    def attach_function! (*args, &block)
      begin
        attach_function(*args, &block)
      rescue Exception => e
        false
      end
    end
  end

  class Type::Builtin
    def name
      inspect[/:(\w+) /][1 .. -2]
    end
  end

  class Pointer
    def typecast (type)
      type = FFI.find_type(type) if type.is_a?(Symbol)

      if type.is_a?(Class) && type.ancestors.member?(FFI::Struct) && !type.is_a?(FFI::ManagedStruct)
        type.new(self)
      elsif type.is_a?(Type::Builtin)
        send "read_#{type.name.downcase}"
      elsif type.respond_to? :from_native
        type.from_native(typecast(type.native_type), nil)
      else
        raise ArgumentError, 'you have to pass a Struct, a Builtin type or a Symbol'
      end
    end

    def read_array_of (type, number)
      type = FFI.find_type(type) if type.is_a?(Symbol)
      type = type.native_type    if type.respond_to? :native_type

      send "read_array_of_#{type.name.downcase}", number
    end
  end

  find_type(:size_t) rescue typedef(:ulong, :size_t)
end

class Integer
	def to_ffi
		self
	end
end

class String
	def to_ffi
		self
	end
end

module X11; module C; extend FFI::Library; end; end
