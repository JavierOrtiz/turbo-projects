class CreateTasks < ActiveRecord::Migration[8.0]
  def change
    create_table :tasks do |t|
      t.references :project, null: false, foreign_key: true
      t.references :task, null: true, foreign_key: true
      t.string :content
      t.datetime :expires_at
      t.integer :status, default: 0, null: false

      t.timestamps
    end
  end
end
