# frozen_string_literal: true

require "rails_helper"

RSpec.describe Todo, type: :model do
  it "has a valid factory" do
    expect(FactoryBot.build(:todo)).to be_valid
  end

  describe "Validations" do
    subject do
      Todo.new(user_id: SecureRandom.uuid,
               content: "Check todo list",
               done: false)
    end
    it { should belong_to(:user) }
  end
end
