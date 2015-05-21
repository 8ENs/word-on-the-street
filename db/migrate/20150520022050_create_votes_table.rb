class CreateVotesTable < ActiveRecord::Migration
  def change
    add_column :tracks, :likes, :integer, :default => 0

    create_table :votes do |t|
      t.belongs_to :track, index: true
      t.belongs_to :user, index: true
      t.integer :vote, :default => 0
      t.timestamps
    end
  end
end
