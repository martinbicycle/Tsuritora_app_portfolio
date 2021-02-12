class AddWcToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :wc, :integer
  end
end
