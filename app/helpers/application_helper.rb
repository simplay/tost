module ApplicationHelper
  def edit_path_of_todo(todo)
    return edit_todo_path(todo) if @category.blank?
    edit_category_todo_path(@category, todo)
  end

  def delete_path_of_todo(todo)
    return todo_path(todo) if @category.blank?
    category_todo_path(@category, todo)
  end

  def add_todo_path
    return new_todo_path if @category.blank?
    new_category_todo_path(@category)
  end
end
