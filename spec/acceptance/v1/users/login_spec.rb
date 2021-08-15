# frozen_string_literal: true

require "rails_helper"
require "rspec_api_documentation/dsl"

resource "Users" do
  explanation "User Login."

  post "/v1/login" do
    parameter :email, "User email",
              required: true
    parameter :password, "User password",
              required: true

    let(:email)    { user.email }
    let(:password) { "Test.234" }
    let!(:user) do
      FactoryBot.create(:user, password: password,
                               password_confirmation: password)
    end

    example "POST /v1/login", document: [:v1] do
      explanation "To be able to login a user."

      do_request

      response = JSON.parse response_body

      expect(response_status).to eq 200
      expect(response["email"]).to eq user.email
    end
  end
end
