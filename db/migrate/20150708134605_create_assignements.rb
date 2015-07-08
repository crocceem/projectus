class CreateAssignements < ActiveRecord::Migration
  def change
    create_table :assignements do |t|

      t.integer :user_id
      t.integer :role_id
      t.integer :project_id

      t.timestamps null: false
    end

    add_index :assignements, :user_id
    add_index :assignements, :role_id
    add_index :assignements, :project_id
    add_index :assignements, [:user_id,:role_id,:project_id], unique: true
  end
end
