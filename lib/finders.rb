# frozen_string_literal: true

module Finders
  extend ActiveSupport::Concern

  # Validates a todos with given id
  #
  # @param [String] id UUID of the todos
  def validate_todo(id:)
    @todo = Todo.find(id)
  end
end
