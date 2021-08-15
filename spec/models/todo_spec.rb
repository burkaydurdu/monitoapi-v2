# frozen_string_literal: true

# == Schema Information
#
# Table name: todos
#
#  id         :uuid             not null, primary key
#  content    :text             not null
#  deleted_at :datetime
#  done       :boolean          default(FALSE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :uuid             not null
#
# Indexes
#
#  index_todos_on_user_id  (user_id)
#
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
