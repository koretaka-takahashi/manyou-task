class AddDefaultToDeadline < ActiveRecord::Migration[5.2]
  def change
    change_column_null :tasks, :deadline, null: false, default: -> { "CURRENT_TIMESTAMP" }
  end
end
