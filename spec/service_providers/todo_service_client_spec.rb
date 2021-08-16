# frozen_string_literal: true

require "rails_helper"
require_relative "pact_helper"
require "httparty"

class TodoServiceClient
  include HTTParty
  base_uri "http://monito.com"

  def create(body, headers)
    JSON.parse(
      self.class.post("/v1/todos", headers: headers, body: body.to_json).body,
      symbolize_names: true
    )
  end

  def index(headers)
    JSON.parse(
      self.class.get("/v1/todos", headers: headers).body,
      symbolize_names: true
    )
  end

  def delete(headers, id)
    JSON.parse(
      self.class.delete("/v1/todos/#{id}", headers: headers).body,
      symbolize_names: true
    )
  end
end

RSpec.describe TodoServiceClient, pact: true do
  before do
    TodoServiceClient.base_uri "localhost:1234"
  end

  subject { TodoServiceClient.new }

  let(:request_body) do
    {
      done: false,
      content: "Read a book"
    }
  end

  let(:response_body) do
    {
      id: "1234-4545-54545-54545-2332",
      done: false,
      content: "Read a book",
      created_at: "2020-07-09T17:47:00.638+03:00",
      updated_at: "2020-07-09T17:47:00.638+03:00"
    }
  end

  let(:response_body_with_list) do
    [
      {
        id: "1234-4545-54545-54545-2332",
        done: false,
        content: "Read a book",
        created_at: "2020-07-09T17:47:00.638+03:00",
        updated_at: "2020-07-09T17:47:00.638+03:00"
      },
      {
        id: "8930-4545-54545-54545-2332",
        done: true,
        content: "Look at the doc",
        created_at: "2020-08-09T17:47:00.638+03:00",
        updated_at: "2020-08-09T17:47:00.638+03:00"
      }
    ]
  end

  let(:headers) do
    {
      "Content-Type" => "application/json; charset=utf-8",
      "Authorization" => "Token token=8538438-34304830843-3493049309430"
    }
  end

  let(:id) { "1234-3431-4353-4565" }

  describe "post create todo service" do
    before do
      monito.given("Success")
            .upon_receiving("Create a new todo.")
            .with(
              method: "POST",
              path: "/v1/todos",
              headers: headers,
              body: request_body
            )
            .will_respond_with(
              status: 200,
              headers: headers,
              body: response_body
            )
    end

    it "should be create a new todo" do
      expect(subject.create(request_body, headers)).to eq(response_body)
    end
  end

  describe "get todo service" do
    before do
      monito.given("Success")
            .upon_receiving("Get todo list")
            .with(
              method: "GET",
              path: "/v1/todos",
              headers: headers
            )
            .will_respond_with(
              status: 200,
              headers: headers,
              body: response_body_with_list
            )
    end

    it "should be return todo lists" do
      expect(subject.index(headers)).to eq(response_body_with_list)
    end
  end

  describe "delete todo service" do
    before do
      monito.given("Success")
            .upon_receiving("Delete a todo.")
            .with(
              method: "DELETE",
              path: "/v1/todos/#{id}",
              headers: headers
            )
            .will_respond_with(
              status: 200,
              headers: headers,
              body: {}
            )
    end

    it "should be delete the todo" do
      expect(subject.delete(headers, id)).to eq({})
    end
  end
end
