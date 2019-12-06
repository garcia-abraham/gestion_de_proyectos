class AddPercentageToTask < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :percentage, :integer
  end
end
