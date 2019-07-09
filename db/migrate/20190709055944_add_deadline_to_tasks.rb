class AddDeadlineToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :deadline, :date, null: false, default: -> { "CURRENT_TIMESTAMP" }
  end
end
