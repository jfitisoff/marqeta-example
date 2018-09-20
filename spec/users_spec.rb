require_relative 'spec_helper'

describe "/users" do
  before(:all) do
    if CREDS.keys.length < 3 || CREDS.values.any? { |v| v.blank? }
      raise "credentials.yml must be populated before running tests (see README.)"
    end

    @api = MarqetaCore.new(
      CREDS['base_url'],
      CREDS['app_token'],
      CREDS['access_token']
    )
  end

  let(:api)          { @api }
  let(:user)         { @api.users.post(FactoryBot.create(:user)) }
  let(:minimal_user) { @api.users.post(FactoryBot.create(:user, :minimal)) }

  context "POST" do
    it "creates a user with minimal parameters" do
      expect(minimal_user).to be_http_201
    end

    it "creates a 'non-minimal' user" do
      expect(user).to be_http_201
    end

    it "raises an error when creating a user with name > 40 chars" do
       expect {api.users.post(first_name: 'a'*41) }.to raise_error(RestClient::BadRequest)
    end
  end
end
