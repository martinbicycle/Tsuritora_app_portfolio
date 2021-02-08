class RenameTagIColumnToPostTags < ActiveRecord::Migration[5.2]
  def change
    rename_column :post_tags, :tag_i, :tag_id
  end
end
