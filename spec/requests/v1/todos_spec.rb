# frozen_string_literal: true

require "rails_helper"

RSpec.describe "V1::Todos", type: :request do
  let!(:user) { FactoryBot.create(:user) }

  let!(:auth_token) { FactoryBot.create(:auth_token, user: user) }

  let!(:headers) { { "Authorization" => "Token token=#{auth_token.token}" } }

  let!(:todo_one) { FactoryBot.create(:todo, user: user) }

  let!(:todo_two) { FactoryBot.create(:todo, user: user) }

  describe "get /index" do
    it "returns todo list" do
      get "/v1/todos", headers: headers

      expect(response).to be_successful
      expect(JSON.parse(response.body).count).to eq 2
    end

    it "returns unauthorized" do
      get "/v1/todos"

      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "post /create" do
    it "should create a todo" do
      post "/v1/todos", headers: headers, params: { content: "fix bug" }

      expect(response).to be_successful
      expect(JSON.parse(response.body)["content"]).to eq "fix bug"
    end

    it "returns unauthorized" do
      post "/v1/todos"

      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "delete /delete" do
    it "should delete a todo" do
      delete "/v1/todos/#{todo_one.id}", headers: headers

      expect(response).to be_successful
    end

    it "returns unauthorized" do
      delete "/v1/todos/#{todo_one.id}"

      expect(response).to have_http_status(:unauthorized)
    end
  end
end
