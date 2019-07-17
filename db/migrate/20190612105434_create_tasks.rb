class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :name, null: false
      t.text :content, null: false, default: '作成中…'
      t.date :deadline, null: false, default: -> { "CURRENT_TIMESTAMP" }
      t.timestamps
    end
  end
end
