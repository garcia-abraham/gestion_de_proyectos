class CreateGroupProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :group_projects do |t|
      t.references :user, foreign_key: true
      t.references :project, foreign_key: true
      t.integer :role

      t.timestamps
    end
  end
end
