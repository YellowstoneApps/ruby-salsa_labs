require "spec_helper"

describe SalsaLabs::SupportersFetcher do

  let(:client) do
    double(
      'API client',
      fetch: File.read('spec/fixtures/getObjects.sjs_supporter.xml')
    )
  end

  describe "#fetch" do
    before(:each) do
      allow(SalsaLabs::ApiClient).to receive(:new) { client }
    end

    it "calls the getObjects API endpoint" do
      SalsaLabs::SupportersFetcher.new.fetch

      expect(client).to have_received(:fetch).
        with('/api/getObjects.sjs', {"condition"=>[], object: 'supporter'})
    end

    it "returns an array of SalsaLabs::Supporter objects" do
      results = SalsaLabs::SupportersFetcher.new.fetch

      expect(results).to be_a(Array)
      expect(results.first).to be_a(SalsaLabs::Supporter)
    end
  end

end
