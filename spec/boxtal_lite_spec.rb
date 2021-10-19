describe BoxtalLite do
  it 'configures authentication' do
    described_class.configure do |config|
      config.api_key = 'test-key'
      config.v1_api_key = 'test-v1-key'
      config.v1_creds = 'test-v1-creds'
    end

    expect(described_class.config.api_key).to eq 'test-key'
    expect(described_class.config.v1_api_key).to eq 'test-v1-key'
    expect(described_class.config.v1_creds).to eq 'test-v1-creds'
  end

  describe '#url' do
    subject { described_class.url }

    it { is_expected.to eq 'https://api.boxtal.build/shipping/v3/' }

    context 'in production mode' do
      before { described_class.config.testing = false }
      it { is_expected.to eq 'https://api.boxtal.com/shipping/v3/' }
    end
  end

  describe '#v1_url' do
    subject { described_class.v1_url }

    it { is_expected.to eq 'https://test.envoimoinscher.com/api/v1/' }

    context 'in production mode' do
      before { described_class.config.testing = false }
      it { is_expected.to eq 'https://www.envoimoinscher.com/api/v1/' }
    end
  end
end
