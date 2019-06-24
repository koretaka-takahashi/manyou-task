class AddDefaultContentToTasks < ActiveRecord::Migration[5.2]
  def change
    change_column_default :tasks, :content, '作製中…'
  end
end
