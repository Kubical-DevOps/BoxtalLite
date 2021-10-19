
describe BoxtalLite::Service do
  describe '.all' do
    subject { described_class.all(params) }

    let(:params) do
      { 
        'shipper.country': 'FR', 'shipper.zipcode': '75009', 'shipper.type': 'company', #from
        'recipient.country': 'FR', 'recipient.zipcode': '69100', 'recipient.type': 'individual', #to
        'colis_0.largeur': 10 ,'colis_0.hauteur': 10, 'colis_0.longueur': 10, 'colis_0.poids': 0.5, 'colis.valeur': 15, #dimensions
        'collection_date': '2021-10-18', 'content_code': '40120' 
      }
    end

    before do
      allow(BoxtalLite.config).to receive(:v1_api_key).and_return('dummy-api-key')
      allow(BoxtalLite.config).to receive(:v1_creds).and_return('dummy-creds')

      stub_api_request(
        :get,
        'https://test.envoimoinscher.com/api/v1/cotation?colis.valeur=15&colis_0.hauteur=10&colis_0.largeur=10&colis_0.longueur=10&colis_0.poids=0.5&collection_date=2021-10-18&content_code=40120&recipient.country=FR&recipient.type=individual&recipient.zipcode=69100&shipper.country=FR&shipper.type=company&shipper.zipcode=75009',
        'spec/fixtures/services_response.xml'
      )
    end

    it 'fetches services' do
      expect(Hash.from_xml(subject)['hash']['cotation']['shipment']['offer']).to be_instance_of(Array)
      expect(Hash.from_xml(subject)['hash']['cotation']['shipment']['offer'][0]['operator']['label']).to eq 'Mondial Relay'
    end
  end
end
