class AddCheckflagToContacts < ActiveRecord::Migration[5.2]
  def change
    add_column :contacts, :checkflag, :boolean
  end
end
