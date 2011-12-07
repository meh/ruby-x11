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

require 'X11/Xlib/window/attributes'
require 'X11/Xlib/window/properties'

module X11

class Window < Drawable
	singleton_named :display, :parent, :x, :y, :width, :height, :border_width, :depth, :input_only?, :visual, :attributes, :optional => 1 .. -1, :alias => { :w => :width, :h => :height }
	def self.create (display, parent=nil, x=nil, y=nil, width=nil, height=nil, border_width=nil, depth=nil, input_only=nil, visual=nil, attributes=nil)
		parent       ||= display.root_window
		x            ||= display.width / 2
		y            ||= display.height / 2
		width        ||= 320
		height       ||= 200
		border_width ||= 0
		depth        ||= :copy
		input_only   ||= :copy
		visual       ||= :copy
		attributes   ||= Attributes.new
	end

	include ForwardTo

	attr_reader :display, :parent, :reported_events
	forward_to  :attributes

	def initialize (display, value)
		super

		@reported_events = Mask::Event[]

		revert_to
	end

	def parent
		root     = FFI::MemoryPointer.new :Window
		parent   = FFI::MemoryPointer.new :Window
		number   = FFI::MemoryPointer.new :uint
		children = FFI::MemoryPointer.new :pointer

		C::XQueryTree(display.to_ffi, id, root, parent, children, number)
		C::XFree(children.typecast(:pointer))

		Window.new(display, parent.typecast(:Window))
	end

	named :parent, :x, :y, :optional => [:x, :y]
	def reparent (parent, x=nil, y=nil)
		position.tap {|p|
			x ||= p.x
			y ||= p.y
		}

		parent.tap {
			C::XReparentWindow(display.to_ffi, to_ffi, parent.to_ffi, x, y)
		}
	end

	def revert_to?
		@revert_to
	end

	def revert_to (value=nil)
		@revert_to = if value.is_a?(Integer)
			RevertTo.key(value)
		else
			revert_to RevertTo[value] || 0
		end
	end

	def attributes
		FFI::MemoryPointer.new(C::XWindowAttributes).tap! {|attr|
			C::XGetWindowAttributes(display.to_ffi, to_ffi, attr)

			Attributes.new(self, attr)
		}
	end

	def viewable?
		attributes.tap! {|attr|
			!attr.input_only? && attr.viewable?
		}
	end

	def properties
		Properties.new(self)
	end

	def size
		attributes.tap! {|attr|
			Struct.new(:width, :height).new(attr.width, attr.height)
		}
	end

	def position
		child = FFI::MemoryPointer.new :Window
		x     = FFI::MemoryPointer.new :int
		y     = FFI::MemoryPointer.new :int

		C::XTranslateCoordinates(display.to_ffi, to_ffi, root.to_ffi, 0, 0, x, y, child)

		Struct.new(:x, :y).new(x.typecast(:int), y.typecast(:int))
	end

	named :x, :y, :optional => [:x, :y]
	def move (x=nil, y=nil)
		position.tap {|p|
			x ||= p.x
			y ||= p.y
		}

		C::XMoveWindow(display.to_ffi, to_ffi, x, y)

		display.flush

		self
	end

	named :width, :height, :optional => [:width, :height], :alias => { :w => :width, :h => :height }
	def resize (width=nil, height=nil)
		attributes.tap {|attr|
			width  ||= attr.width
			height ||= attr.height
		}

		C::XResizeWindow(display.to_ffi, to_ffi, width, height)

		display.flush

		self
	end

	def raise
		C::XRaiseWindow(display.to_ffi, to_ffi)
		display.flush
		self
	end

	def iconify
		C::XIconifyWindow(display.to_ffi, to_ffi, screen.to_i)
		display.flush
		self
	end

	def withdraw
		C::XWithdrawWindow(display.to_ffi, to_ffi, screen.to_i)
		display.flush
		self
	end

	def lower
		C::XLowerWindow(display.to_ffi, to_ffi)
		display.flush
		self
	end

	def map (subwindows=false)
		if subwindows
			C::XMapSubwindows(display.to_ffi, to_ffi)
		else
			C::XMapWindow(display.to_ffi, to_ffi)
		end

		display.flush

		self
	end

	def unmap (subwindows=false)
		if subwindows
			C::XMapSubwindows(display.to_ffi, to_ffi)
		else
			C::XMapWindow(display.to_ffi, to_ffi)
		end

		self
	end

	def destroy (subwindows=false)
		if subwindows
			C::XDetroyWindow(display.to_ffi, to_ffi)
		else
			C::XDestroySubwindows(display.to_ffi, to_ffi)
		end

		display.flush
		make_unusable

		self
	end

	def subwindows (deep=false)
		Enumerator.new do |e|
			root     = FFI::MemoryPointer.new :Window
			parent   = FFI::MemoryPointer.new :Window
			number   = FFI::MemoryPointer.new :uint
			children = FFI::MemoryPointer.new :pointer

			C::XQueryTree(display.to_ffi, id, root, parent, children, number)

			next if children.typecast(:pointer).null?

			children.typecast(:pointer).read_array_of(:Window, number.typecast(:uint)).each {|win|
				Window.new(display, win).tap! {|win|
					e.yield win

					if deep
						win.subwindows(true).each {|win|
							e.yield win
						}
					end
				}
			}

			C::XFree(children.typecast(:pointer))
		end
	end

	named :normal?, :mask, :pointer, :keyboard, :confine_to, :cursor, :time, :optional => 0 .. -1
	def grab_pointer (owner_events=true, event_mask=Mask::Event[:NoEvent], pointer_mode=:sync, keyboard_mode=:async, confine_to=0, cursor=0, time=0, &block)
		result = C::XGrabPointer(display.to_ffi, to_ffi, !!owner_events, event_mask.to_ffi, mode_to_int(pointer_mode), mode_to_int(keyboard_mode), confine_to.to_ffi, cursor.to_ffi, time).zero?

		if block && result
			begin
				result = block.call self
			ensure
				ungrab_pointer
			end
		end

		result
	end

	def ungrab_pointer (time=0)
		display.ungrab_pointer(time)
	end

	named :key, :modifiers, :normal?, :pointer, :keyboard, :optional => 1 .. -1
	def grab_key (keycode, modifiers=0, owner_events=true, pointer_mode=:async, keyboard_mode=:sync)
		C::XGrabKey(display.to_ffi, Keysym[keycode, display].to_keycode, modifiers, to_ffi, !!owner_events, mode_to_int(pointer_mode), mode_to_int(keyboard_mode))
	end

	def ungrab_key (keycode, modifiers=0)
		C::XUngrabKey(display.to_ffi, Keysym[keycode, display].to_keycode, modifiers, to_ffi)
	end

	named :button, :modifiers, :normal?, :mask, :pointer, :keyboard, :confine_to, :cursor, :optional => 0 .. -1
	def grab_button (button, modifiers=0, owner_events=true, event_mask=Mask::Event[:ButtonPress], pointer_mode=:async, keyboard_mode=:sync, confine_to=0, cursor=0)
		C::XGrabButton(display.to_ffi, button, modifiers, to_ffi, !!owner_events, event_mask.to_ffi, mode_to_int(pointer_mode), mode_to_int(keyboard_mode), confine_to.to_ffi, cursor.to_ffi)
	end

	def ungrab_button (button, modifiers=0)
		C::XUngrabButton(display.to_ffi, button, modifiers, to_ffi)
	end

	def under_pointer
		root  = FFI::MemoryPointer.new :Window
		child = FFI::MemoryPointer.new :Window
		dummy = FFI::MemoryPointer.new :int

		C::XQueryPointer(display.to_ffi, to_ffi, root, child, dummy, dummy, dummy, dummy, dummy)

		Window.new(display, child.typecast(:Window))
	end

	def pointer_at? (on_root=false)
		dummy = FFI::MemoryPointer.new :Window
		y     = FFI::MemoryPointer.new :int
		x     = FFI::MemoryPointer.new :int

		if on_root
			C::XQueryPointer(display.to_ffi, to_ffi, dummy, dummy, x, y, dummy, dummy, dummy)
		else
			C::XQueryPointer(display.to_ffi, to_ffi, dummy, dummy, dummy, dummy, x, y, dummy)
		end

		[x.typecast(:int), y.typecast(:int)]
	end

	def reported_events= (mask)
		mask = Mask::Event[mask] unless mask.is_a?(Bitmap::Value)

		(@reported_events = mask).tap {
			C::XSelectInput(display.to_ffi, to_ffi, mask.to_ffi)
		}
	end; alias select_input reported_events=

	def next_event (what=nil, options=nil, &block)
		what, options = if what.is_a?(Hash)
			[Mask::Event.all, what]
		else
			[what, options || {}]
		end


# this would be cool, but it's slow as hell, if anyone finds a way to optimize it, let me know
=begin
		mask = Event.mask_for(what)

		old, self.reported_events = if options[:select] != false && !reported_events.has?(mask)
			[reported_events, mask]
		end

		display.next_event(what, options) {|event|
			if event.window == self
				block ? block.call(event) : true
			end
		}.tap {
			self.reported_events = old if old
		}
=end

		event = FFI::MemoryPointer.new(C::XEvent)

		if block
			callback = FFI::Function.new(:Bool, [:pointer, :pointer, :pointer]) do |_, event|
				block.call Event.new(event) if event.window == self
			end

			@reported_events.tap {|old|
				self.reported_events = Mask::Event.all unless options[:select] == false

				begin
					if options[:blocking?] == false
						C::XCheckIfEvent(display.to_ffi, event, callback, nil) or return
					else
						if options[:delete] != false
							C::XIfEvent(display.to_ffi, event, callback, nil)
						else
							C::XPeekIfEvent(display.to_ffi, event, callback, nil)
						end
					end
				ensure
					self.reported_events = old unless options[:select] == false
				end
			}
		else
			if what.is_a?(Symbol) && options[:blocking?] == false
				Kernel.raise ArgumentError, 'cannot look for event by type and block'
			end

			if what.is_a?(Symbol)
				C::XCheckTypedWindowEvent(display.to_ffi, to_ffi, Event.index(what), event) or return
			else
				old  = reported_events
				what = Mask::Event.all if what.nil?

				self.reported_events += what unless options[:select] == false || old.has?(what)

				if options[:blocking?] == false
					C::XCheckWindowEvent(display.to_ffi, to_ffi, what.to_ffi, event) or return
				else
					C::XWindowEvent(display.to_ffi, to_ffi, what.to_ffi, event)
				end

				if options[:delete] == false
					C::XPutBackEvent(to_ffi, event.to_ffi)
				end

				self.reported_events = old unless reported_events == old
			end
		end

		Event.new(event)
	end

	def each_event (what=nil, options=nil, &block)
		return unless block

		catch(:skip) {
			loop {
				next_event(what, options).tap {|event|
					if !event
						return if options[:blocking] == false
						next
					end

					block.call event
				}
			}
		}
	end

	def inspect
		begin
			attributes.tap! {|attr|
				"#<X11::Window(#{id}): #{attr.width}x#{attr.height} (#{attr.x}; #{attr.y})>"
			}
		rescue BadWindow
			"#<X11::Window: invalid window>"
		end
	end

	protected

	def mode_to_int (mode)
		(mode == true || mode == :async) ? 1 : 0
	end
end

end
