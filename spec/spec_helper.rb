$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'boxtal_lite'
require 'dotenv'
require 'webmock/rspec'
require 'active_support/core_ext/hash'

Dotenv.load
WebMock.disable_net_connect!

Dir['./spec/support/**/*.rb'].each { |f| require(f) }

RSpec.configure do |config|
  config.before do
    BoxtalLite.configure do |config|
      config.api_key = ENV['BOXTAL_API_KEY']
      config.testing = true
    end
  end
end
