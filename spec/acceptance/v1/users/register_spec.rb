# frozen_string_literal: true

require "rails_helper"
require "rspec_api_documentation/dsl"

resource "Users" do
  explanation "User Register."

  post "/v1/register" do
    parameter :name, "User name",
              required: true
    parameter :surname, "User surname",
              required: true
    parameter :email, "User email",
              required: true
    parameter :password, "User password",
              required: true

    let(:name)     { "Burkay" }
    let(:surname)  { "Durdu" }
    let(:email)    { "burkay12312.durdu@outlook.com" }
    let(:password) { "Test!123" }

    example "POST /v1/register", document: [:v1] do
      explanation "To be able to register a user."

      do_request

      response = JSON.parse response_body

      expect(response_status).to eq 200
      expect(response["name"]).to eq name
    end
  end
end
