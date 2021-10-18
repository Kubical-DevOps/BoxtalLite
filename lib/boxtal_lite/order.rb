
  module BoxtalLite
    class Order
      PATH = 'shipping-order'

      def self.create(payload, options = {})
        BoxtalLite.client.post(PATH, payload, options)
      end
    end
  end

