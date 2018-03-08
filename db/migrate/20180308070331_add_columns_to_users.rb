class AddColumnsToUsers < ActiveRecord::Migration[5.0]
  def up
  	add_column :users, :total_points, :integer, default: 0

  	User.reset_column_information
  	User.all.each do |user|
  		user.update_attribute(:total_points, user.points.sum(:value))
  	end
  end

  def down
  	remove_column :users, :total_points
  end
end
