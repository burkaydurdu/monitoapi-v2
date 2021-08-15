# frozen_string_literal: true

FactoryBot.define do
  factory :todo do
    association :user
    content     { Faker::Lorem.sentence }
    done        { Faker::Boolean.boolean }
  end
end
