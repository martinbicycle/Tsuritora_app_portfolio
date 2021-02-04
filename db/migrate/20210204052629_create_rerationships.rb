class CreateRerationships < ActiveRecord::Migration[5.2]
  def change
    create_table :rerationships do |t|
      t.integer :following_id
      t.integer :follower_id  
      t.timestamps
    end
  end
end
