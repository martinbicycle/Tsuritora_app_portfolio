class ChangeRerationshipsToRelationships < ActiveRecord::Migration[5.2]
  def change
    rename_table :rerationships, :relationships
  end
end
