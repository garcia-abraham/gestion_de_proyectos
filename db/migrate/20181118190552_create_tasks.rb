class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.references :user, foreign_key: true
      t.references :project, foreign_key: true
      t.string :name
      t.string :detail
      t.date :start_date
      t.date :finish_date
      t.integer :status

      t.timestamps
    end
  end
end
