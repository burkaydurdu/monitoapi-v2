# frozen_string_literal: true
class V1::TodosController < V1::ApplicationController
  def create
    authorize Todo

    @todo = Todo.new(todo_params.merge(user: current_user))

    return render_success(TodoSerializer.new(@todo)) if @todo.save

    render_error(Error::STANDARD_ERROR)
  rescue StandardError
    raise AppException::MissingParameter
  end

  private

    def todo_params
      params.permit(:content, :done)
    end
end
