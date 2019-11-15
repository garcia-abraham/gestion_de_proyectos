class RemoveTaskFromResource < ActiveRecord::Migration[5.2]
  def change
    remove_reference :resources, :task, foreign_key: true
  end
end
