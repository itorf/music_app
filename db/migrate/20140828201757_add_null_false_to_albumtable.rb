class AddNullFalseToAlbumtable < ActiveRecord::Migration
  def change
    remove_column :albums, :band_id
    
    add_column :albums, :band_id, :integer, null: false
  end
end
