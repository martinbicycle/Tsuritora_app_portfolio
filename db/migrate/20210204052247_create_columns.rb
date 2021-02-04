class CreateColumns < ActiveRecord::Migration[5.2]
  def change
    create_table :columns do |t|
      t.integer :admin_id
      t.integer :contact_id
      t.string :title
      t.text :body
      t.string :image_id  
      t.timestamps
    end
  end
end
