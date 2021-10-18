require 'faraday'
require 'faraday_middleware'
require 'nokogiri'

  module BoxtalLite
    class Client
      def get(path, params = nil, options = {})
        with_error_handling do
          response = connection(options[:api_key]).get(path, params)
          response.body
        end
      end

      def v1_get(path, params = nil, options = {})
        with_v1_error_handling do
          response = v1_connection(options[:api_key], options[:creds]).get(path, params)
          response.body
        end
      end

      def post(path, payload, options = {})
        begin
          response = connection(options[:creds]).post(path, payload)
        rescue => e
          raise e.inspect
        end
          response.body
      end

      def delete(path, options = {})
        with_error_handling do
          response = connection(options[:creds]).delete(path)
          response.body
        end
      end


      def with_error_handling
        yield
      rescue Faraday::ClientError => e
        message = extract_error_message(e.response[:body]) if e.response
        message ||= e.message

        raise(Error, message)
      end

      def with_v1_error_handling
        yield
      rescue Faraday::ClientError => e
        message = extract_v1_error_message(e.response[:body]) if e.response
        message ||= e.message

        raise(Error, message)
      end

      def connection(api_key)
        token = api_key || BoxtalLite.config.api_key
        raise(Error, 'v3 API key is not set') unless token
        @connection = build_connection
        @connection.headers['Authorization'] = "Basic #{token}"
        @connection.headers['Content-Type'] = 'application/json'
        @connection
      end

      def v1_connection(api_key, creds)

        token = api_key || BoxtalLite.config.v1_api_key
        raise(Error, 'API key is not set') unless token
        @connection = build_v1_connection
        @connection.headers['Access_key'] = token
        @connection.headers['Authorization'] = "Basic #{creds}"
        @connection
      end

      def build_connection
        Faraday.new(url: BoxtalLite.url) do |builder|
          builder.options[:timeout] = config.timeout
          builder.options[:open_timeout] = config.timeout

          builder.request :json

          builder.headers['Accept'] = 'application/json'
          builder.response :json, content_type: /\bjson$/
          builder.response :raise_error

          builder.adapter Faraday.default_adapter
        end
      end

      def build_v1_connection
        Faraday.new(url: BoxtalLite.v1_url) do |builder|
          builder.options[:timeout] = config.timeout
          builder.options[:open_timeout] = config.timeout
          #builder.request :xml
          builder.headers['Accept'] = 'application/xml'

          builder.response :xml, content_type: /\bxml$/
          builder.response :raise_error

          builder.adapter Faraday.default_adapter
        end
      end

      def extract_error_message(response_body)
        result = JSON.parse(response_body)
        result['message'] || result['messages']
      rescue JSON::ParserError
      end

      def extract_v1_error_message(response_body)
        result = Nokogiri::XML(response_body)
        result.xpath('//error/message').text || result.xpath('//error/messages').text
      rescue Nokogiri::XML::SyntaxError
      end

      def config
        BoxtalLite.config
      end
    end
  end

