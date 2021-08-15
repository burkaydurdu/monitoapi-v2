# frozen_string_literal: true

require "rails_helper"

RSpec.describe "V1::Users", type: :request do
  let!(:password) { "Test.234" }

  let!(:user) do
    FactoryBot.create(:user, password: password,
                             password_confirmation: password)
  end

  describe "POST /v1/register" do
    it "success register" do
      post "/v1/register", params: { email: Faker::Internet.email,
                                     name: Faker::Name.first_name,
                                     surname: Faker::Name.last_name,
                                     password: "Test.234" }

      expect(response).to be_successful
    end

    it "should return bad request if the email is already exists" do
      post "/v1/register", params: { email: user.email,
                                     name: Faker::Name.first_name,
                                     surname: Faker::Name.last_name,
                                     password: "Test.234" }

      expect(response).to have_http_status(:conflict)
    end

    it "should return bad request if there are missing parameters" do
      post "/v1/register", params: { email: user.email,
                                     name: Faker::Name.first_name,
                                     surname: Faker::Name.last_name }

      expect(response).to have_http_status(:bad_request)
    end
  end
end
