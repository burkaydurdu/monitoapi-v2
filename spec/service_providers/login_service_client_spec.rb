# frozen_string_literal: true

require "rails_helper"
require_relative "pact_helper"
require "httparty"

class LoginServiceClient
  include HTTParty
  base_uri "http://monito.com"

  def login(body, headers)
    JSON.parse(
      self.class.post("/v1/login", headers: headers, body: body.to_json).body,
      symbolize_names: true
    )
  end
end

RSpec.describe LoginServiceClient, pact: true do
  before do
    LoginServiceClient.base_uri "localhost:1234"
  end

  subject { LoginServiceClient.new }

  let(:request_body) do
    {
      email: "burkaydurdu@outlook",
      password: "Burkay.67"
    }
  end

  let(:response_body) do
    {
      id: "1234-4545-54545-54545-2332",
      name: "Burkay",
      surname: "Durdu",
      email: "burkaydurdu@outlook",
      token: "xxx-111asdaskifdjfdsf"
    }
  end

  let(:headers) do
    { "Content-Type" => "application/json; charset=utf-8" }
  end

  describe "post login service" do
    before do
      monito.given("Success")
            .upon_receiving("Check a user.")
            .with(
              method: "POST",
              path: "/v1/login",
              headers: headers,
              body: request_body
            )
            .will_respond_with(
              status: 200,
              headers: headers,
              body: response_body
            )
    end

    it "responds with things" do
      expect(subject.login(request_body, headers)).to eq(response_body)
    end
  end
end
