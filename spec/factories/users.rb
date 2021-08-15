# frozen_string_literal: true
# == Schema Information
#
# Table name: users
#
#  id              :uuid             not null, primary key
#  deleted_at      :datetime
#  email           :string           not null
#  name            :string           not null
#  password_digest :string           not null
#  surname         :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
FactoryBot.define do
  factory :user do
    email                 { Faker::Internet.email }
    password              { "Test.234" }
    password_confirmation { "Test.234" }
    name                  { Faker::Name.first_name }
    surname               { Faker::Name.last_name }
  end
end
