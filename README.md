X11 bindings for Ruby
=====================

We need a good set of bindings to interface with X in Ruby, seriously.

This is still in an early stage, so don't expect to do much.

```ruby
>> X11::Display.new.width
1280
```

It uses ffi to use Xlib and stuff, long live FFI!

Notes
-----

Keep in mind that when a Display object gets garbage collected the connection to the X server
is closed and the data is free'd, so anything related to that display won't work anymore and
could cause crashes.
