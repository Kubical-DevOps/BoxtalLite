describe BoxtalLite::Order do
  describe '.create' do
    subject { described_class.create(payload) }

    let(:payload) { JSON.parse(request_json) }
    let(:request_json) { File.read('spec/fixtures/order_create_request.json') }

    before do
      allow(BoxtalLite.config).to receive(:api_key).and_return('dummy-api-key')

      stub_api_request(
        :post,
        'https://api.boxtal.build/shipping/v3/shipping-order',
        'spec/fixtures/order_create_response.json'
      )
    end

    it 'creates order' do
      expect(subject).to be_instance_of(Hash)
      expect(subject['shippingOrder']['id']).to eq 'RandomID'
    end
  end
end
