require "integration_helper"


describe "saving a supporter" do
  let(:supporter_email) { Faker::Internet.email }
  it "should not blank out the create date", integration: true do
    # verify that supporter does not already exist
    fetcher = SalsaLabs::SupportersFetcher.new({'Email' => supporter_email}, SANDBOX_CREDENTIALS)
    existing_record = (fetcher.fetch).first
    expect(existing_record).to be_nil

    supporter = SalsaLabs::Supporter.new first_name: 'ControlShift', last_name: "Integration Test", email: supporter_email
    supporter.save

    new_record = (fetcher.fetch).first
    expect(new_record).to_not be_nil
    expect(new_record.date_created).to_not be_blank

    # save the newly created record to update it. 
    new_record.save
    expect(new_record).to_not be_nil
    expect(new_record.date_created).to_not be_blank

    # now get the record again from Salsa, to check it's current status. 
    new_record = (fetcher.fetch).first
    expect(new_record.date_created).to_not be_blank
  end 
end