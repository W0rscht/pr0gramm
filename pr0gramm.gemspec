$LOAD_PATH.push File.expand_path('../lib', __FILE__)
require 'rake'
require 'pr0gramm/version'

Gem::Specification.new do |s|
  s.name        = 'pr0gramm'
  s.version     = Pr0gramm::VERSION
  s.date        = '2015-10-03'
  s.summary     = 'pr0gramm.com API'
  s.description = 'A Ruby interface to the pr0gramm.com API.'
  s.authors     = ['W0rscht']
  s.email       = 'none@rubygems.org'
  s.homepage    = 'http://pr0gramm.com/user/W0rscht'
  s.platform    = Gem::Platform::RUBY
  s.licenses    = ['GPL-3']

  # files
  s.files         = `git ls-files`.split("\n")
  s.require_paths = ['lib']

  s.add_runtime_dependency 'rest-client', '~> 1.8.0', '~> 1.8.0'
end
