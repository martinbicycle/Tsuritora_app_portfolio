class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.string :name
      t.text :body
      t.string :image_id, null: false
      t.string :size
      t.datetime :fish_time
      t.string :address
      t.float :latitude
      t.float :longitude
      t.string :lure  
      t.timestamps
    end
  end
end
