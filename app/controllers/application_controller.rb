# frozen_string_literal: true

class ApplicationController < ActionController::API
  # Finders raise ActiveRecord::RecordNotFound if not found
  rescue_from ActiveRecord::RecordNotFound do |e|
    render_error(AppError::NOT_FOUND, "#{e.model.downcase}_id" => e.id)
  end

  # DRY some controller methods:
  rescue_from ActiveRecord::RecordInvalid do |e|
    render_error(AppError::PARAM_INVALID, e.record.errors)
  end

  # DRY some controller methods:
  rescue_from ActiveModel::ValidationError do |e|
    render_error(AppError::PARAM_INVALID, e.model.errors)
  end

  # DRY some controller methods:
  rescue_from AppException do |e|
    render_error(e.options)
  end

  # Error will occure when deleting model that has some associations like
  # has_many :models, dependent: :restrict_with_exception
  rescue_from ActiveRecord::DeleteRestrictionError do |e|
    render_error(AppError::COULDNT_DESTROY, message: e.message)
  end

  # Render success methods that returns a response with HTTP 200.
  #
  # @param [Hash] payload Payload data
  def render_success(payload = {})
    render json: payload, status: :ok
  end

  # Render the given error message and status wrt error.rb.
  #
  # @param [Hash] options Error options. with keys:
  #               [String]  message, error message
  #               [Symbole] status, http status
  #               [Integer] code, error code
  # @param [Hash] errors. Error detail when relevant. Example: AR error
  def render_error(options = {}, errors = nil)
    error = { error_message: options[:message],
              data: options[:message],
              code: (options[:code] || 400),
              errors: error_hash(errors) }
    render json: error, status: options[:status]
  end

  # Format ActiveModel::Errors
  def error_hash(errors)
    return errors unless errors.is_a? ActiveModel::Errors

    { details: errors.details,
      messages: errors.messages,
      full_messages: errors.full_messages }
  end

  def default_serializer_options
    { root: false }
  end

  # Log the not found path
  def not_found
    logger.warn "UNKNOWN PATH: #{request.inspect}"
    render status: :not_found
  end
end
