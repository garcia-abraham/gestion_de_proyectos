class AddPorcentajeToTask < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :porcentaje, :decimal
  end
end
