
  module BoxtalLite
    class Service
      PATH = 'cotation'
      def self.all(query, options = {})
        BoxtalLite.client.v1_get(PATH, query, options)
      end
    end
  end

