# frozen_string_literal: true
require "rails_helper"

RSpec.describe "V1::Logistrations", type: :request do
  let!(:password) { "Test.234" }

  let!(:user) do
    FactoryBot.create(:user, password: password,
                             password_confirmation: password)
  end

  let!(:auth_token) { FactoryBot.create(:auth_token, user: user) }

  let!(:headers) { { "Authorization" => "Token token=#{auth_token.token}" } }

  let!(:invalid_headers) do
    { "Authorization" => "Token token=#{SecureRandom.urlsafe_base64(32, false)}" }
  end

  describe "POST /login" do
    it "success login" do
      post "/v1/login", params: { email: user.email,
                                  password: "Test.234" }

      expect(response).to be_successful
    end

    it "should not find a user" do
      post "/v1/login", params: { email: "bob",
                                  password: "Test.234" }

      expect(response).to have_http_status(:not_found)
    end

    it "returns bad request if there isn't email param" do
      post "/v1/login", params: { password: "Test.234" }

      expect(response).to have_http_status(:bad_request)
    end

    it "returns bad request if there isn't password param" do
      post "/v1/login", params: { email: user.email }

      expect(response).to have_http_status(:bad_request)
    end
  end

  describe "POST /logout" do
    it "success logout" do
      post "/v1/logout", headers: headers

      expect(response).to be_successful
    end

    it "returns wrong authentication token" do
      post "/v1/logout", headers: invalid_headers

      expect(response).to have_http_status(:unauthorized)
    end
  end
end
