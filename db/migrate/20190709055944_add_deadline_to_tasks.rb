class AddDeadlineToTasks < ActiveRecord::Migration[5.2]
  def change
    change_column_default :tasks, :deadline, -> { "CURRENT_TIMESTAMP" }
  end
end
