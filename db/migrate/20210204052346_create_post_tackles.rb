class CreatePostTackles < ActiveRecord::Migration[5.2]
  def change
    create_table :post_tackles do |t|
      t.integer :post_id
      t.integer :tackle_id  
      t.timestamps
    end
  end
end
