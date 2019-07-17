class AddDefaultContentToTasks < ActiveRecord::Migration[5.2]
  def up
    change_column_default :tasks, :content, '作成中…'
  end
end
