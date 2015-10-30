require "spec_helper"

describe SalsaLabs::Supporter do

  let(:attributes) do
    {
      'supporter_key' => '31337',
      'organization_key' => '1234',
      'chapter_key' => '90210',
      'title' => 'Mr.',
      'first_name' => 'John',
      'mi' => 'Jacob',
      'last_name' => 'Jingleheimer Schmidt',
      'suffix' => 'IV',
      'email' => 'johnjacob@example.com',
      'receive_email' => 1,
      'phone' => '1234567890',
      'street' => '123 Main St',
      'street_2' => 'Apt 404',
      'city' => 'Schnechtady',
      'state' => 'NY',
      'zip' => '12345',
      'country' => 'USA',
      'source' => 'rspec',
      'status' => 'Active',
      'source_details' => 'foo123',
      'source_tracking_code' => 'foo123',
      'tracking_code' => 'abc123',
      'date_created' => 'Fri Mar 14 2014 14:07:29 GMT-0400 (EDT)',
      'last_modified' => 'Fri Mar 14 2014 13:54:10 GMT-0400 (EDT)'
    }
  end

  let(:supporter) { SalsaLabs::Supporter.new(attributes) }

  describe 'initialization' do
    let(:attributes) { {:first_name => 'George'} }
    it 'should accept symbol keys' do
      expect(supporter.first_name).to eq('George')
    end

    it 'should be a supporter' do
      expect(SalsaLabs::Supporter.object_name).to eq('supporter')
      expect(supporter.object_name).to eq('supporter')
    end
  end

  describe "#attributes" do
    it "returns the attributes hash passed in to initialize" do
      expect(supporter.attributes).to eq(attributes)
    end
  end

  describe "#supporter_key" do
    it "returns the suppoter_key attribute as an integer" do
      expect(supporter.supporter_key).to eq(31337)
    end
  end

  describe "#organization_key" do
    it "returns the organization_key attribute as an integer" do
      expect(supporter.organization_key).to eq(1234)
    end
  end

  describe "#chapter_key" do
    it "returns the chapter_key attribute as an integer" do
      expect(supporter.chapter_key).to eq(90210)
    end
  end

  describe "#title" do
    it "returns the title as an attribute" do
      expect(supporter.title).to eq('Mr.')
    end
  end

  describe "#first_name" do
    it "returns the first name as an attribute" do
      expect(supporter.first_name).to eq('John')
    end
  end

  describe "#first_name=" do
    it "sets the first name as an attribute" do
      supporter.first_name = 'Nathan'
      expect(supporter.first_name).to eq('Nathan')
    end
  end

  describe "#mi" do
    it "returns the middle initial as an attribute" do
      expect(supporter.mi).to eq('Jacob')
    end
  end

  describe "#last_name" do
    it "returns the last_name as an attribute" do
      expect(supporter.last_name).to eq('Jingleheimer Schmidt')
    end
  end

  describe "#suffix" do
    it "returns the suffix as an attribute" do
      expect(supporter.suffix).to eq('IV')
    end
  end

  describe "#email" do
    it "returns the email as an attribute" do
      expect(supporter.email).to eq('johnjacob@example.com')
    end
  end

  describe "#receive_email" do
    it "returns the receive email as a boolean" do
      expect(supporter.receive_email).to eq(true)
    end
  end

  describe "#phone" do
    it "returns the phone as an attribute" do
      expect(supporter.phone).to eq('1234567890')
    end
  end

  describe "#street" do
    it "returns the street as an attribute" do
      expect(supporter.street).to eq('123 Main St')
    end
  end

  describe "#street_2" do
    it "returns the street_2 as an attribute" do
      expect(supporter.street_2).to eq('Apt 404')
    end
  end

  describe "#city" do
    it "returns the city as an attribute" do
      expect(supporter.city).to eq('Schnechtady')
    end
  end

  describe "#state" do
    it "returns the state as an attribute" do
      expect(supporter.state).to eq('NY')
    end
  end

  describe "#zip" do
    it "returns the zip as an attribute" do
      expect(supporter.zip).to eq('12345')
    end
  end

  describe "#country" do
    it "returns the country as an attribute" do
      expect(supporter.country).to eq('USA')
    end
  end

  describe "#source" do
    it "returns the source as an attribute" do
      expect(supporter.source).to eq('rspec')
    end
  end

  describe "#status" do
    it "returns the status as an attribute" do
      expect(supporter.status).to eq('Active')
    end
  end

  describe "#tracking_code" do
    it "returns the status as an attribute" do
      expect(supporter.tracking_code).to eq('abc123')
    end
  end

  describe 'dates' do
    it "returns the status as an attribute" do
      expect(supporter.date_created.iso8601).to eq('2014-03-14T14:07:29-04:00')
      expect(supporter.last_modified.iso8601).to eq('2014-03-14T13:54:10-04:00')
    end
  end

  describe '#tracking_info_blank?' do
    context 'source details and tracking code filled in' do
      it 'should be false' do
        expect(supporter.tracking_info_blank?).to be_falsey
      end
    end

    context 'source_details nil, source_tracking_code filled in' do
      before(:each) do
        supporter.source_details = nil
      end

      it 'should be false' do
        expect(supporter.tracking_info_blank?).to be_falsey
      end
    end

    context 'source_details nil, source_tracking_code nil' do
      before(:each) do
        supporter.source_details = nil
        supporter.source_tracking_code = nil
      end

      it 'should be true' do
        expect(supporter.tracking_info_blank?).to be_truthy
      end
    end

    context 'source_details default, source_tracking_code default' do
      before(:each) do
        supporter.source_details = 'No Referring info'
        supporter.source_tracking_code = 'No Original Source'
      end

      it 'should be true' do
        expect(supporter.tracking_info_blank?).to be_truthy
      end
    end
  end

  describe ".fetch" do
    let(:supporters_fetcher) { double('SupportersFetcher', fetch: []) }

    before(:each) do
      allow(SalsaLabs::SupportersFetcher).to receive(:new).and_return(supporters_fetcher)
    end

    it "calls .fetch on an SalsaLabs::SupportersFetcher object" do
      SalsaLabs::Supporter.fetch

      expect(supporters_fetcher).to have_received(:fetch)
    end
  end

  describe 'save' do

    let(:object_saver) { double('SalsaObjectsSaver', save: []) }

    before(:each) do
      allow(SalsaLabs::SalsaObjectsSaver).to receive(:new).and_return(object_saver)
    end

    it "calls .fetch on an SalsaLabs::SupportersFetcher object" do
      supporter.save

      expect(object_saver).to have_received(:save)
    end
  end
end
