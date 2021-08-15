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
class User < ApplicationRecord
  acts_as_paranoid
  has_secure_password

  #
  # One to many between user and auth tokens.
  has_many :auth_tokens, dependent: :destroy

  validates :password, format: { with: Regexmn::PASSWORD_FORMAT,
                                 if: :password_digest_changed? }

  #
  # Name, surname, email and password should be present.
  validates :email, :password_digest, presence: true
  #
  # Email should be unique
  validates :email, uniqueness: { scope: :deleted_at }
  #
  # Email format validation.
  validates :email,
            format: { with: Regexmn::EMAIL_FORMAT,
                      on: :create }

  # Authenticate user by token.
  #
  # @param [String] id UUID of user
  # @param [String] token Authentication token
  #
  # @return [User] User
  def self.authenticate_by_token(id, token)
    user = User.find_by(id: id)
    token = AuthToken.find_by(token: token)

    # return user if valid, else nil
    return user if token && user && token.user_id == user.id

    nil
  end

  def generate_token!
    token = AuthToken.generate
    auth_tokens.create(token: token)

    token
  end
end
