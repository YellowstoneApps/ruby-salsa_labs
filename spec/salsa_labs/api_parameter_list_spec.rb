require 'spec_helper'
require 'vcr'

describe SalsaLabs::ApiObjectParameterList do

  let(:api_parameters) do
    #non capitalized parameter names
    SalsaLabs::ApiObjectParameterList.new({
      'key' => '1234',
      'uid' => '',
      'object' => 'supporter',
      'tag' => 'a_tag',
      'supporter_key' => '1234',
      'organization_key' => '90210',
      'title' => 'Mr.',
      'first_name' => 'John',
      'mi' => 'Jacob',
      'last_name' => 'Jingleheimer Schmidt',
      'suffix' => 'IV',
      'zip' => '12345',
      'private_zip_plus_4' => '0000'
    })
  end

  describe "#capitalize" do
    it "properly capitalizes attributes" do
      #not capitalized
      expect(api_parameters.attributes).to include('key')
      expect(api_parameters.attributes['key']).to eq('1234')
      expect(api_parameters.attributes).to include('object')
      expect(api_parameters.attributes['object']).to eq('supporter')
      expect(api_parameters.attributes).to include('uid')
      expect(api_parameters.attributes['uid']).to eq('')
      expect(api_parameters.attributes).to include('tag')
      expect(api_parameters.attributes['tag']).to eq('a_tag')

      #ends with _KEY
      expect(api_parameters.attributes).to include('supporter_KEY')
      expect(api_parameters.attributes['supporter_KEY']).to eq('1234')
      expect(api_parameters.attributes).to include('organization_KEY')
      expect(api_parameters.attributes['organization_KEY']).to eq('90210')

      #starts with PRIVATE_
      expect(api_parameters.attributes).to include('PRIVATE_Zip_Plus_4')
      expect(api_parameters.attributes['PRIVATE_Zip_Plus_4']).to eq('0000')

      #all caps
      expect(api_parameters.attributes).to include('MI')
      expect(api_parameters.attributes['MI']).to eq('Jacob')

      #normally capitalized
      expect(api_parameters.attributes).to include('Title')
      expect(api_parameters.attributes['Title']).to eq('Mr.')
      expect(api_parameters.attributes).to include('First_Name')
      expect(api_parameters.attributes['First_Name']).to eq('John')
      expect(api_parameters.attributes).to include('Last_Name')
      expect(api_parameters.attributes['Last_Name']).to eq('Jingleheimer Schmidt')
      expect(api_parameters.attributes).to include('Suffix')
      expect(api_parameters.attributes['Suffix']).to eq('IV')
      expect(api_parameters.attributes).to include('Zip')
      expect(api_parameters.attributes['Zip']).to eq('12345')

      #negative tests
      api_parameters.attributes.should_not include('supporter_key')
      api_parameters.attributes.should_not include('private_zip_plus_4')
      api_parameters.attributes.should_not include('mi')
      api_parameters.attributes.should_not include('title')
    end
  end

end
