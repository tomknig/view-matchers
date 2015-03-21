require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start

require 'view_matchers'

RSpec.configure do |config|
  config.include ViewMatchers
end
