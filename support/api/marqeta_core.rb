require "klient"

# Partial implementation of the core API using a client library that I'm
# working on.
class MarqetaCore
  include Klient
  default_collection_accessor :data

  def initialize(base_url, app_token, access_token)
    super(
      base_url,
      content_type: :json,
      accept: :json,
      authorization: "Basic " + Base64.strict_encode64("#{app_token}:#{access_token}")
    )
  end

  collection :acceptedcountries, identifier: 'token'
  collection :cardproducts, identifier: 'token'

  collection :users, identifier: 'token' do
    resource :auth do
      resource :changepassword
      collection :clientaccesstoken, identifier: 'token' do
        resources :login, :logout, :onetime
        collection :resetpassword, identifier: 'token'
        collection :clientaccesstoken, identifier: 'token'
        collection :verifyemail, identifier: 'token'
      end
    end

    resources :children, :lookup, :ssn

    collection :phonenumber, identifier: 'token'
    collection :notes, identifier: 'token'
  end
end
