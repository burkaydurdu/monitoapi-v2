# frozen_string_literal: true

class ApplicationService
  include Pundit

  def initialize(params = {})
    @params = params
  end

  def self.call(params = {})
    new(params).tap(&:call)
  end

  def current_user
    params[:current_user]
  end

  private

    attr_reader :params
end
