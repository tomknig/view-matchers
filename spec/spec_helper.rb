require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start

require 'view/matchers'

RSpec.configure do |config|
  config.include ViewMatchers
end
