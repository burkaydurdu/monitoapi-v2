# frozen_string_literal: true
module AppError
  STANDARD_ERROR = {
    message: "An error occured",
    status: :bad_request,
    code: 13_000
  }.freeze

  # The clients connects to the API with authentication token.
  # This token should be valid.
  WRONG_AUTHENTICATION_TOKEN = {
    message: "Wrong authentication token",
    status: :unauthorized,
    code: 13_001
  }.freeze

  NOT_FOUND = {
    message: "Requested resource not found!",
    status: :not_found,
    code: 13_002
  }.freeze

  # Wrong credentials error message.
  RESET_TOKEN_NOT_FOUND = {
    message: "Reset Token not found",
    status: :not_found,
    code: 13_003
  }.freeze

  # When an object couldn't be destroyed
  COULDNT_DESTROY = {
    message: "Record could not be deleted",
    status: :bad_request,
    code: 13_008
  }.freeze

  USER_NOT_FOUND = {
    message: "User not found",
    status: :not_found,
    code: 13_010
  }.freeze

  # When old password of a user does not match
  PASSWORD_MISMATCH = {
    message: "Password does not match the old password",
    status: :conflict,
    code: 13_012
  }.freeze

  PERMISSION_DENIED = {
    message: "Permission denied",
    status: :forbidden,
    code: 13_013
  }.freeze

  PARAM_MISSING = {
    message: "Required field not present in params!",
    status: :bad_request,
    code: 13_015
  }.freeze

  TOKEN_NOT_FOUND = {
    message: "Token not found",
    status: :not_found,
    code: 13_016
  }.freeze

  RESPONSE_NOT_FOUND = {
    message: "Response not found",
    status: :not_found,
    code: 13_018
  }.freeze

  PARAM_INVALID = {
    message: "Invalid parameters",
    status: :bad_request,
    code: 13_028
  }.freeze

  EMAIL_ALREADY_EXISTS = {
    message: "Email already exists",
    status: :conflict,
    code: 13_017
  }.freeze
end
