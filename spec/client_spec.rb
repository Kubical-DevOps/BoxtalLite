describe BoxtalLite::Client do
  context 'when v3 API key is not set' do
    before do
      BoxtalLite.config.api_key = nil
    end

    it 'raises error' do
      expect { subject.get('shipping-order') }.to raise_error(BoxtalLite::Error, /API key/)
    end
  end

  context 'when v1 API key is not set' do
    before do
      BoxtalLite.config.v1_api_key = nil
    end

    it 'raises error' do
      expect { subject.v1_get('cotation') }.to raise_error(BoxtalLite::Error, /v1 API key/)
    end
  end

  context 'when v1 Creds are not set' do
    before do
      BoxtalLite.config.v1_api_key = 'dummy-api-key'
      BoxtalLite.config.v1_creds = nil
    end

    it 'raises error' do
      expect { subject.v1_get('cotation') }.to raise_error(BoxtalLite::Error, /v1 Creds/)
    end
  end

  context 'when API key is not passed' do
    before do
      allow(BoxtalLite.config).to receive(:api_key).and_return('dummy-api-key')
      allow(BoxtalLite.config).to receive(:v1_api_key).and_return('dummy-v1-api-key')
      allow(BoxtalLite.config).to receive(:v1_creds).and_return('dummy-v1-creds')
    end

    it 'uses v3 api key from configuration' do
      stub_request(:get, 'https://api.boxtal.build/shipping/v3/shipping-order')
        .with(headers: { 'Authorization' => "Basic #{BoxtalLite.config.api_key}" })
        .to_return(body: 'ok')

      subject.get('shipping-order')
    end

    it 'uses v1 api key from configuration' do
      stub_request(:get, 'https://test.envoimoinscher.com/api/v1/cotation')
        .with(headers: { 'Access_key' => BoxtalLite.config.v1_api_key })
        .to_return(body: 'ok')

      subject.v1_get('cotation')
    end

    it 'uses v1 creds from configuration' do
      stub_request(:get, 'https://test.envoimoinscher.com/api/v1/cotation')
        .with(headers: { 'Authorization' => "Basic #{BoxtalLite.config.v1_creds}" })
        .to_return(body: 'ok')

      subject.v1_get('cotation')
    end
  end

  context 'when API key is passed' do
    it 'uses api key from configuration' do
      stub_request(:get, 'https://api.boxtal.build/shipping/v3/shipping-order')
        .with(headers: { 'Authorization' => 'Basic 123' })
        .to_return(body: 'ok')

      subject.get('shipping-order', {}, api_key: '123')
    end
  end

  context 'with authorization error' do
    before do
      allow(BoxtalLite.config).to receive(:api_key).and_return('dummy-api-key')

      stub_api_request(
        :get,
        'https://api.boxtal.build/shipping/v3/shipping-order',
        'spec/fixtures/unauthorized.json',
        status: 401
      )
    end

    it 'raises error' do
      expect { subject.get('shipping-order') }.to raise_error(BoxtalLite::Error, /Unauthorized/)
    end
  end

  context 'with v1 authorization error' do
    before do
      allow(BoxtalLite.config).to receive(:v1_api_key).and_return('dummy-api-key')
      allow(BoxtalLite.config).to receive(:v1_creds).and_return('dummy-creds')
      stub_api_request(
        :get,
        'https://test.envoimoinscher.com/api/v1/cotation',
        'spec/fixtures/v1_unauthorized.xml',
        status: 401
      )
    end

    it 'raises error' do
      expect { subject.v1_get('cotation') }.to raise_error(BoxtalLite::Error, /authorization or access_key header is missing/)
    end
  end

  context 'with v1 bad request error' do
    before do
      allow(BoxtalLite.config).to receive(:api_key).and_return('dummy-api-key')
      allow(BoxtalLite.config).to receive(:v1_creds).and_return('dummy-creds')

      stub_api_request(
        :get,
        'https://test.envoimoinscher.com/api/v1/cotation',
        'spec/fixtures/shipment_type_error.xml',
        status: 401
      )
    end

    it 'raises error' do
      expect { subject.v1_get('cotation') }.to raise_error(BoxtalLite::Error, /Missing shipment type/)
    end
  end

end
