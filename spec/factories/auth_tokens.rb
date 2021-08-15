# frozen_string_literal: true
# == Schema Information
#
# Table name: auth_tokens
#
#  id         :uuid             not null, primary key
#  deleted_at :datetime
#  token      :string(43)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :uuid             not null
#
# Indexes
#
#  index_auth_tokens_on_user_id  (user_id)
#
FactoryBot.define do
  factory :auth_token do
    association :user
    token { SecureRandom.urlsafe_base64(32, false) }
  end
end
