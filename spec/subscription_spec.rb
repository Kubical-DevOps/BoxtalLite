describe BoxtalLite::Subscription do
    describe '.create' do
      subject { described_class.create(payload) }
  
      let(:payload) { JSON.parse(request_json) }
      let(:request_json) { File.read('spec/fixtures/subscription_request.json') }
  
      before do
        allow(BoxtalLite.config).to receive(:api_key).and_return('dummy-api-key')
  
        stub_api_request(
          :post,
          'https://api.boxtal.build/shipping/v3/subscription',
          'spec/fixtures/subscription_response.json'
        )
      end
  
      it 'creates subscription' do
        expect(subject).to be_instance_of(Hash)
        expect(subject['subscription']['eventType']).to eq 'DOCUMENT_CREATED'
      end
    end
  end
  