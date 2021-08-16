# frozen_string_literal: true
class V1::TodosController < V1::ApplicationController
  before_action -> { validate_todo(id: params[:id]) },
                only: [:destroy]

  def index
    authorize Todo

    @todos = current_user.todos

    serialized_todos = ActiveModel::ArraySerializer.new(
      @todos,
      each_serializer: TodoSerializer
    )

    render_success(serialized_todos)
  end

  def create
    authorize Todo

    @todo = Todo.new(todo_params.merge(user: current_user))

    return render_success(TodoSerializer.new(@todo)) if @todo.save

    render_error(Error::STANDARD_ERROR)
  rescue StandardError
    raise AppException::MissingParameter
  end

  def destroy
    authorize @todo

    @todo.destroy

    render_success
  end

  private

    def todo_params
      params.permit(:content, :done)
    end
end
