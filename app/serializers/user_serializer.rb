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
class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :surname, :email, :token

  # Return the authentication token with serialized user.
  #
  # @return [String] Authentication token
  def token
    @options[:token]
  end
end
