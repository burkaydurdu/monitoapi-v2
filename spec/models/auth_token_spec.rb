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
require "rails_helper"

RSpec.describe AuthToken, type: :model do
  it "has a valid factory" do
    expect(FactoryBot.build(:auth_token)).to be_valid
  end

  describe "Validations" do
    subject do
      AuthToken.new(user_id: SecureRandom.uuid,
                    token: SecureRandom.urlsafe_base64(32, false))
    end
    it { should belong_to(:user) }
    it { should validate_presence_of(:token) }
    it { should validate_uniqueness_of(:token) }
    it { should validate_length_of(:token).is_equal_to(43) }
  end
end
