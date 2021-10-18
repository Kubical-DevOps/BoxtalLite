
  module BoxtalLite
    class Subscription
      PATH = 'subscription'
      
      def self.create(payload, options = {})
        BoxtalLite.client.post(PATH, payload, options)
      end
    end
  end