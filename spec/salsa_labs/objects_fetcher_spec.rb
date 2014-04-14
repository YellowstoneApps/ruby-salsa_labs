require 'spec_helper'

describe SalsaLabs::ObjectsFetcher do
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
      SalsaLabs::ObjectsFetcher.fetch(type: 'Action').fetch

      expect(client).to have_received(:fetch).
        with('/api/getObjects.sjs', {object: 'Action'})
    end

    it "returns an array of SalsaLabs::Action objects" do
      results = SalsaLabs::ObjectsFetcher.fetch(type: 'Action', item_class: SalsaLabs::Action).fetch

      expect(results).to be_a(Array)
      expect(results.first).to be_a(SalsaLabs::Action)
    end

    it "parses the actions" do
      action = SalsaLabs::ObjectsFetcher.fetch(type: 'Action', item_class: SalsaLabs::Action).fetch.first

      expect(action.action_key).to eq(6656)
      expect(action.description).to eq("<p>&#160;</p>")
      expect(action.title).to eq("My Action Title")
      expect(action.reference_name).to eq("My TItle")
    end
  end
end
