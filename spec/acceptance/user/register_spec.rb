# frozen_string_literal: true

require "rails_helper"

RSpec.resource "User" do
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
    let(:email)    { "burkaydurdu@outlook.com" }
    let(:password) { "Test!123" }

    example "POST /v1/register", document: [:private] do
      explanation "To be able to register a user."

      do_request
      expect(response_status).to eq 200
      expect(result["name"]).to eq name
    end
  end
end
