class AddIndexToUsersCip < ActiveRecord::Migration
  def change
    add_index :users, :cip, unique:true
  end
end
