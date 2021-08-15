# frozen_string_literal: true

require "rails_helper"
require "rspec_api_documentation/dsl"

resource "Todos" do
  explanation "Create a todo."

  post "/v1/todos" do
    parameter :done, "Todo status"
    parameter :content, "Todo content",
              required: true

    let(:content) { "Read a book" }
    let(:done)    { false }

    example "POST /v1/todos", document: [:v1] do
      explanation "To be able to create a todo."

      do_request

      response = JSON.parse response_body

      expect(response_status).to eq 200
      expect(response["content"]).to eq content
    end
  end
end
