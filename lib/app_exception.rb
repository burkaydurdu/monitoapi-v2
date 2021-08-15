# frozen_string_literal: true
class AppException < StandardError
  attr_reader :data, :code, :status, :options

  OPTIONS = AppError::STANDARD_ERROR

  def initialize(data = nil, code = nil, status = nil)
    @data   = data   || self.class::OPTIONS[:message]
    @code   = code   || self.class::OPTIONS[:code]
    @status = status || self.class::OPTIONS[:status]
    @options = { message: @data, status: @status, code: @code }
  end

  def to_s
    "#{data} [#{code}]"
  end

  ###########################################################
  # The following can be raise with AppException:: prefix
  ###########################################################

  class UserNotFound < AppException
    OPTIONS = AppError::USER_NOT_FOUND
  end

  class PasswordDontMatch < AppException
    OPTIONS = AppError::PASSWORD_MISMATCH
  end

  class MissingParameter < AppException
    OPTIONS = AppError::PARAM_MISSING
  end

  class RecordInvalid < AppException
    OPTIONS = AppError::PARAM_INVALID
  end

  class BadRequest < AppException
    OPTIONS = AppError::STANDARD_ERROR
  end

  class EmailAlreadyExists < AppException
    OPTIONS = AppError::EMAIL_ALREADY_EXISTS
  end
end
