class CreateResources < ActiveRecord::Migration[5.2]
  def change
    create_table :resources do |t|
      t.references :task, foreign_key: true
      t.string :name
      t.decimal :price, :precision => 8, :scale => 2
      t.integer :quantity

      t.timestamps
    end
  end
end
