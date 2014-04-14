require 'spec_helper'

describe SalsaLabs::SupporterAction do
  it "returns action_key" do
    supporter_action = SalsaLabs::SupporterAction.new('action_key' => '123')

    expect(supporter_action.action_key).to eq(123)
  end

  it "returns nil for nil action_key" do
    supporter_action = SalsaLabs::SupporterAction.new({})

    expect(supporter_action.action_key).to be_nil
  end

  it "returns supporter_key" do
    supporter_action = SalsaLabs::SupporterAction.new('supporter_key' => '123')

    expect(supporter_action.supporter_key).to eq(123)
  end

  it "returns nil for nil supporter_key" do
    supporter_action = SalsaLabs::SupporterAction.new({})

    expect(supporter_action.supporter_key).to be_nil
  end

  it "returns supporter_action_key" do
    supporter_action = SalsaLabs::SupporterAction.new('supporter_action_key' => '123')

    expect(supporter_action.supporter_action_key).to eq(123)
  end

  it "returns nil for nil supporter_action_key" do
    supporter_action = SalsaLabs::SupporterAction.new({})

    expect(supporter_action.supporter_action_key).to be_nil
  end

  describe ".fetch" do
    it "fetches the supporter actions" do
      SalsaLabs::ObjectsFetcher.stub(:fetch)

      SalsaLabs::SupporterAction.fetch(email: "foo@bar.com",
                                       password: "pass")

      expect(SalsaLabs::ObjectsFetcher).to have_received(:fetch).with(
        credentials: {email: "foo@bar.com", password: "pass"},
        type: "supporter_action",
        item_class: SalsaLabs::SupporterAction)
    end
  end
end
