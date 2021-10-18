require 'boxtal_lite/version'
require 'boxtal_lite/configuration'
require 'boxtal_lite/errors'
require 'boxtal_lite/client'
require 'boxtal_lite/service'
require 'boxtal_lite/order'
require 'boxtal_lite/subscription'

  module BoxtalLite
    PRODUCTION_URL = 'https://api.boxtal.com/shipping/v3/'
    SANDBOX_URL = 'https://api.boxtal.build/shipping/v3/'
    V1_PRODUCTION_URL = 'https://www.envoimoinscher.com/api/v1/'
    V1_SANDBOX_URL = 'https://test.envoimoinscher.com/api/v1/'

    module_function

    def configure
      yield(config)
    end

    def config
      @configuration ||= Configuration.new
    end

    def client
      @client ||= Client.new
    end

    def url
      config.testing? ? SANDBOX_URL : PRODUCTION_URL
    end

    def v1_url
      config.testing? ? V1_SANDBOX_URL : V1_PRODUCTION_URL
    end
  end
