class AddBodyToContacts < ActiveRecord::Migration[5.2]
  def change
    add_column :contacts, :body, :text
  end
end
