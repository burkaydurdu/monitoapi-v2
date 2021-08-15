# frozen_string_literal: true

require "rails_helper"
require_relative "pact_helper"
require "httparty"

class RegisterServiceClient
  include HTTParty
  base_uri "http://monito.com"

  def register(body, headers)
    JSON.parse(
      self.class.post("/v1/register", headers: headers, body: body.to_json).body,
      symbolize_names: true
    )
  end
end

RSpec.describe RegisterServiceClient, pact: true do
  before do
    RegisterServiceClient.base_uri "localhost:1234"
  end

  subject { RegisterServiceClient.new }

  let(:request_body) do
    {
      name: "Burkay",
      surname: "Durdu",
      email: "burkaydurdu@outlook",
      password: "Burkay.67"
    }
  end

  let(:response_body) do
    {
      id: "1234-4545-54545-54545-2332",
      name: "Burkay",
      surname: "Durdu",
      email: "burkaydurdu@outlook"
    }
  end

  let(:headers) do
    { "Content-Type" => "application/json; charset=utf-8" }
  end

  describe "post register service" do
    context "Things exist" do
      before do
        monito.given("Success")
              .upon_receiving("Create a new user.")
              .with(
                method: "POST",
                path: "/v1/register",
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
        expect(subject.register(request_body, headers)).to eq(response_body)
      end
    end
  end
end







# describe "Srvice cik", :pact => true do

#   # before do
#   #   # Configure your client to point to the stub service on localhost using the port you have specified
#   #   AnimalServiceClient.base_uri 'localhost:1234'
#   # end

#   # subject { AnimalServiceClient.new }

#   describe "get_alligator" do

#     before do
#       animal_service.given("an alligator exists").
#         upon_receiving("a request for an alligator").
#         with(method: :get, path: '/alligator', query: '').
#         will_respond_with(
#           status: 200,
#           headers: {'Content-Type' => 'application/json'},
#           body: {name: 'Betty'} )
#     end

#     it "returns a alligator" do
#       # expect(subject.get_alligator.name).to eq(Alligator.new('Betty').name)
#       expect(1).to eq 1
#     end

#   end

# end

