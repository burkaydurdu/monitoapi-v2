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
FactoryBot.define do
  factory :todo do
    association :user
    content     { Faker::Lorem.sentence }
    done        { Faker::Boolean.boolean }
  end
end
