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
    @category = Category.find_by_id params[:category_id]
  end

  def create
    @todo = Todo.new todo_params

    try_load_category do
      @todo.categories << @category
    end

    if @todo.save
      if @category
        redirect_to category_path(@category)
      else
        redirect_to todos_path
      end
    else
      redirect_to new_todo_path
    end
  end

  def edit
    @todo = Todo.find params[:id]
    @category = Category.find_by_id params[:category_id]
  end

  def update
    @todo = Todo.find params[:id]

    try_load_category

    if @todo.update_attributes(todo_params)
      if @category
        redirect_to category_path(@category)
      else
        redirect_to todos_path
      end
    else
      redirect_to edit_todo_path(@todo)
    end
  end

  def destroy
    @todo = Todo.find params[:id]

    try_load_category
    @todo.destroy

    if @category
      redirect_to category_path(@category)
    else
      redirect_to todos_path
    end
  end

  private

  def try_load_category(&block)
    category_id = params[:category_id]
    unless category_id.blank?
      @category = Category.find category_id
      yield block if block_given?
    end
  end

  def todo_params
    params.require(:todo).permit(
      :title,
      :description,
      :due,
      :done
    )
  end

end

