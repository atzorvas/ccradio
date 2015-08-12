ENV['RAILS_ENV'] ||= 'test'
require "codeclimate-test-reporter"
CodeClimate::TestReporter.start
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/mock'
require 'vcr'
# require 'mocha/test_unit'
#
VCR.configure do |c|
  c.cassette_library_dir = 'test/cassettes'
  c.hook_into :webmock
end

class ActiveSupport::TestCase
  fixtures :all
end
