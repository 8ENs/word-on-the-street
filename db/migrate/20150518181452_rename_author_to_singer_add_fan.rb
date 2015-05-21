class RenameAuthorToSingerAddFan < ActiveRecord::Migration
  def change
    rename_column :tracks, :song_title, :song
    rename_column :tracks, :author, :album
    rename_column :tracks, :url, :artist
    add_column :tracks, :url, :string
    add_column :tracks, :fan, :string
  end
end
