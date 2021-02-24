class ChangeDatatypeStateOfPosts < ActiveRecord::Migration[5.2]
  def change
    change_column :posts, :state, :integer
  end
end
