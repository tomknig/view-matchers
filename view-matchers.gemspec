$:.push File.join(File.dirname(__FILE__), 'lib')
require 'view/matchers/version'

Gem::Specification.new do |s|
  s.name        = 'view-matchers'
  s.version     = ViewMatchers::VERSION
  s.date        = Time.now.strftime('%Y-%m-%d')
  s.summary     = 'RSpec-compatible testing matchers for common view contents.'
  s.description = 'Expressive and non verbose view tests.'
  s.authors     = ['Tom König']
  s.email       = 'hi@tomknig.de'
  s.files       = ['lib/view-matchers.rb']
  s.homepage    = 'https://github.com/TomKnig/view-matchers'
  s.license     = 'MIT'
end
