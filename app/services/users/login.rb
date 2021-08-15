# frozen_string_literal: true

class Users::Login < ApplicationService
  attr_reader :user, :token

  def call
    find_user
    authenticate_user
    generate_token
  end

  private

    def find_user
      raise AppException::MissingParameter if params[:email].blank?

      @user = User.find_by(email: params[:email].downcase)

      raise AppException::UserNotFound unless @user
    end

    def authenticate_user
      Users::Authenticate.call(password: params[:password], user: @user)
    rescue AppException => e
      raise e
    end

    def generate_token
      @token = @user.generate_token!
    end
end
