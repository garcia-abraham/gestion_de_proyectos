class CreateResourceTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :resource_tasks do |t|
      t.references :task, foreign_key: true
      t.references :resource, foreign_key: true
      t.integer :quantity
      t.decimal :total, :precision => 8, :scale => 2
    end
  end
end
