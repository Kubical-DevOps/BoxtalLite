
  module BoxtalLite
    class Configuration
      attr_accessor :api_key, :v1_api_key,  :testing, :timeout
      alias testing? testing

      def timeout
        @timeout || 30
      end
    end
  end

