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

    it 'supports filtering by email' do
      SalsaLabs::SupportersFetcher.new('Email' => 'george@washington.com').fetch

      expect(client).to have_received(:fetch).
                          with('/api/getObjects.sjs', {"condition"=>["Email=george@washington.com"], object: 'supporter'})
    end

    describe 'supporter parsing' do
      let(:supporter) { SalsaLabs::SupportersFetcher.new.fetch.first }

      specify { supporter.supporter_key.should eq(33984504)  }
      specify { supporter.receive_email.should eq(true) }
      specify { supporter.first_name.should eq('John') }
    end
  end
end
