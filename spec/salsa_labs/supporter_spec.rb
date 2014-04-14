require 'spec_helper'

describe SalsaLabs::Supporter do
  let(:supporter) { SalsaLabs::Supporter.new('email' => 'bob@example.com',
                                             'supporter_key' => '123') }

  it "returns supporter's key" do
    expect(supporter.supporter_key).to eq(123)
  end

  it "returns supporter's email" do
    expect(supporter.email).to eq('bob@example.com')
  end

  describe ".fetch" do
    it "passes the credentials to object fetcher" do
      SalsaLabs::ObjectsFetcher.stub(:fetch)

      SalsaLabs::Supporter.fetch(email: 'foo@bar.com', password: 'pass')

      expect(SalsaLabs::ObjectsFetcher).to have_received(:fetch).with(
        type: 'supporter',
        item_class: SalsaLabs::Supporter,
        credentials: {
          email: 'foo@bar.com',
          password: 'pass'
        })
    end
  end
end
