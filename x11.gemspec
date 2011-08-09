Gem::Specification.new {|s|
  s.name         = 'x11'
  s.version      = '0.0.1a1'
  s.author       = 'meh.'
  s.email        = 'meh@paranoici.org'
  s.homepage     = 'http://github.com/meh/ruby-x11'
  s.platform     = Gem::Platform::RUBY
  s.summary      = 'Bindings for X11'
  s.files        = Dir.glob('lib/**/*.rb')
  s.require_path = 'lib'

  s.add_dependency('ffi')

  s.add_dependency('memoized')
  s.add_dependency('refining')
  s.add_dependency('retarded')
	s.add_dependency('bitmap')
}
