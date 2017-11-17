module ApplicationHelper
  def edit_path_of_todo(todo)
    return edit_todo_path(todo) if @category.blank?
    edit_category_todo_path(@category, todo)
  end

  def delete_path_of_todo(todo)
    return todo_path(todo) if @category.blank?
    category_todo_path(@category, todo)
  end
end
