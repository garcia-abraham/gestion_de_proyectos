class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.string :name
      t.text :detail
      t.date :start_date
      t.date :finish_date
      t.integer :status

      t.timestamps
    end
  end
end
