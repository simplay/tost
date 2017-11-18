class CategoriesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def show
    @category = Category.find params[:id]
    @todos = @category.todos.reject(&:done)
  end
end

