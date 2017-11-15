class TodosController < ApplicationController
  skip_before_action :verify_authenticity_token

  def show
    @todo = Todo.find params[:id]
  end

  def index
    @todos = Todo.all
  end

  def new
    @todo = Todo.new
  end

  def create
    @todo = Todo.new todo_params
    if @todo.save
      redirect_to todos_path
    else
      redirect_to new_todo_path
    end
  end

  def edit
    @todo = Todo.find params[:id]
  end

  def update
    @todo = Todo.find params[:id]
    if @todo.update_attributes(todo_params)
      redirect_to todos_path
    else
      redirect_to edit_todo_path(@todo)
    end
  end

  def destroy
    @todo = Todo.find params[:id]
    if @todo.destroy

    end
    redirect_to todos_path
  end

  private

  def todo_params
    params.require(:todo).permit(
      :title,
      :description,
      :due,
      :done
    )
  end

end

