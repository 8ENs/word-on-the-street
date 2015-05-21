class AddUsers < ActiveRecord::Migration
  def change
    # remove_column :tracks, :fan
    # add_column(:tracks, :user_id, :integer)
    # add_index(:tracks, :user_id)

    change_table :tracks do |t|
      t.remove :tracks, :fan
      t.belongs_to :user, index: true
    end

    create_table "users", force: true do |t|
      t.string "name"
      t.string "email"
      t.timestamps
    end
  end
end
