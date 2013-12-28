require "spec_helper"

describe SalsaLabs::Action do

  let(:attributes) do
    {
      'action_key' => '1234',
      'description' => 'Lengthy Description',
      'organization_key' => '90210',
      'reference_name' => 'A Good Reference',
      'title' => 'A Distinguished Title'
    }
  end

  let(:action) { SalsaLabs::Action.new(attributes) }

  describe "#action_key" do
    it "returns the action_key attribute as an integer" do
      expect(action.action_key).to eq(1234)
    end
  end

  describe "#attributes" do
    it "returns the attributes hash passed in to initialize" do
      expect(action.attributes).to eq(attributes)
    end
  end

  describe "#description" do
    it "returns the description attribute" do
      expect(action.description).to eq('Lengthy Description')
    end
  end

  describe "#organization_key" do
    it "returns the organization_key attribute as an integer" do
      expect(action.organization_key).to eq(90210)
    end
  end

  describe "#reference_name" do
    it "returns the reference_name attribute" do
      expect(action.reference_name).to eq('A Good Reference')
    end
  end

  describe "#title" do
    it "returns the title as an attribute" do
      expect(action.title).to eq('A Distinguished Title')
    end
  end

  describe ".fetch" do
    let(:actions_fetcher) { double('ActionsFetcher', fetch: []) }

    before(:each) do
      SalsaLabs::ActionsFetcher.stub(new: actions_fetcher)
    end

    it "calls .fetch on an SalsaLabs::ActionsFetcher object" do
      SalsaLabs::Action.fetch

      expect(actions_fetcher).to have_received(:fetch)
    end
  end

end
