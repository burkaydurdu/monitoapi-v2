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
class AuthToken < ApplicationRecord
  acts_as_paranoid
  #
  # Many to one between auth tokens and users.
  belongs_to :user

  ## Validations
  #
  # Authentication tokens should be 43 characters and unique.
  validates :token, length: { is: 43 }, presence: true, uniqueness: true

  # Generates a secure random authentication token.
  #
  # @param [Integer] length Length for SecureRandom base64
  # @param [Integer] padding Padding for SecureRandom base64
  #
  # @return [String] Random authentication token
  def self.generate(length = 32, padding: false)
    SecureRandom.urlsafe_base64(length, padding)
  end
end
