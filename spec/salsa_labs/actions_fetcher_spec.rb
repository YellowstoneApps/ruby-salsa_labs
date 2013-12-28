require "spec_helper"

describe SalsaLabs::ActionsFetcher do

  let(:client) do
    double(
      'API client',
      fetch: File.read('spec/fixtures/getObjects.sjs_action.xml')
    )
  end

  describe "#fetch" do
    before(:each) do
      allow(SalsaLabs::ApiClient).to receive(:new) { client }
    end

    it "calls the getObjects API endpoint" do
      SalsaLabs::ActionsFetcher.new.fetch

      expect(client).to have_received(:fetch).
        with('/api/getObjects.sjs', {object: 'Action'})
    end

    it "returns an array of SalsaLabs::Action objects" do
      results = SalsaLabs::ActionsFetcher.new.fetch

      expect(results).to be_a(Array)
      expect(results.first).to be_a(SalsaLabs::Action)
    end
  end

end
