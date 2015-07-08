class AddActiveToAssignements < ActiveRecord::Migration
  def change
    add_column :assignements, :active, :boolean
  end
end
