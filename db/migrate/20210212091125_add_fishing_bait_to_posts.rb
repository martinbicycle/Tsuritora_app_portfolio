class AddFishingBaitToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :fishing_bait, :integer
  end
end
