$:.push File.join(File.dirname(__FILE__), 'lib')
require 'view_matchers/version'

Gem::Specification.new do |s|
  s.name          = 'view-matchers'
  s.version       = ViewMatchers::VERSION
  s.date          = Time.now.strftime('%Y-%m-%d')
  s.summary       = 'RSpec matchers for ascii tables and form fields.'
  s.description   = 'Expressive RSpec matchers for ascii tables and form fields.'
  s.authors       = ['Tom König']
  s.email         = 'hi@tomknig.de'
  s.files         = `git ls-files`.split($/)
  s.require_paths = ['lib']
  s.homepage      = 'https://github.com/TomKnig/view-matchers'
  s.license       = 'MIT'
end
