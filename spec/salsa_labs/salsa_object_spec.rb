require "spec_helper"

describe SalsaLabs::SalsaObject do

  let(:attributes) do
    {
      "description" => "A depiction of a description",
      "organization_key" => "456"
    }
  end

  let(:salsa_object) { SalsaLabs::SalsaObject.new(attributes) }

  describe "#attributes" do
    it "returns the hash used to construct the object" do
      expect(salsa_object.attributes).to eq(attributes)
    end
  end

  describe "#organization_key" do
    it "returns the organization_key attribute as an integer" do
      expect(salsa_object.organization_key).to eq(456)
    end
  end

end
