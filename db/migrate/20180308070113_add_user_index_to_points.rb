class AddUserIndexToPoints < ActiveRecord::Migration[5.0]
  def change
    add_index :points, :user_id
  end
end
