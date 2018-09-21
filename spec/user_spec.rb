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

  context "GET" do
    it "gets an individual resource" do
      expect(api.users.get(user.token).status_code).to eq(200)
    end

    it "gets a collection" do
      arr = api.users.get
      expect(arr.length).to be > 1
    end

    it "accepts a pagination count" do
      expect(api.users.get(count: 2).length).to eq(2)
    end

    it "accepts a start index for the query" do
      first  = api.users.get.first
      second = api.users.get(start_index: 2).first
      expect(first.token).to_not eq(second.token)
    end

    xit "handles 'search_type' query parameter" do
    end

    it "limits fields returned when using 'fields' query parameter" do
      expect(user.get(fields: "last_name").attributes.first_name).to be_nil
    end

    it "sorts results by lastModifiedTime, descending" do
      x = api.users.get(sort_by: '-lastModifiedTime').map(&:last_modified_time)
      expect(x).to eq(x.sort.reverse)
    end

    it "sorts results by lastModifiedTime, ascending" do
      x = api.users.get(sort_by: 'lastModifiedTime').map(&:last_modified_time)
      expect(x).to eq(x.sort)
    end

    it "sorts results by createdTime, descending" do
      x = api.users.get(sort_by: '-createdTime').map(&:created_time)
      expect(x).to eq(x.sort.reverse)
    end

    it "sorts results by createdTime, ascending" do
      x = api.users.get(sort_by: 'lastName').map(&:created_time)
      expect(x).to eq(x.sort)
    end

    it "sorts results by lastName, descending (case insensitive)" do
      x = api.users.get(count: 50, sort_by: '-lastName')
        .map(&:last_name)
        .map(&:to_s)
        .map(&:downcase)

      expect(x).to eq(x.sort.reverse)
    end

    it "sorts results by lastName, ascending (case insensitive)" do
      x = api.users.get(count: 50, sort_by: 'lastName')
        .map(&:last_name)
        .map(&:to_s)
        .map(&:downcase)

      expect(x).to eq(x.sort)
    end
  end

  context "POST" do
    it "creates a user with minimal parameters" do
      expect(minimal_user.status_code).to eq(201)
    end

    it "creates a 'non-minimal' user" do
      expect(user.status_code).to eq(201)
    end

    it "raises an error when creating a user with name > 40 chars" do
       expect {api.users.post(first_name: 'a'*41) }.to raise_error(RestClient::BadRequest)
    end
  end
end
