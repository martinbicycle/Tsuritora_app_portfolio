class AddConvenienceStoreToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :convenience_store, :integer
  end
end
