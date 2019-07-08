class ChangeColumnNullToFalse < ActiveRecord::Migration[5.2]
  def change
    change_column_null :tasks, :deadline, null: false
  end
end
