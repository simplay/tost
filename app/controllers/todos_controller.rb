class TodosController < ApplicationController
  skip_before_action :verify_authenticity_token

  def show
    @todo = Todo.find params[:id]
  end

  def index
    @todos = Todo.all
  end

  def new
    @todo = Todo.new(title: params[:todo][:title])
    @category = Category.find_by_id params[:category_id]
  end

  def create
    @todo = Todo.new todo_params

    update_categories
    try_load_category do
      unless @todo.categories.include?(@category)
        @todo.categories << @category
      end
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

    update_categories
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

  def update_categories
    category_ids = params[:todo][:category_ids]
    unless category_ids.blank?
      categories = category_ids.reject(&:blank?).map do |id|
        Category.find id
      end
      @todo.categories = categories
    end
  end

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
