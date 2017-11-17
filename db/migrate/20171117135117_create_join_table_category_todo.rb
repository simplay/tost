class CreateJoinTableCategoryTodo < ActiveRecord::Migration[5.1]
  def change
    create_join_table :categories, :todos do |t|
      t.index [:category_id, :todo_id]
    end
  end
end
