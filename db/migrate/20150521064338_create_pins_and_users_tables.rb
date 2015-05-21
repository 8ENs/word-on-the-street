class CreatePinsAndUsersTables < ActiveRecord::Migration
  def change
    create_table "users", force: true do |t|
      t.string "name"
      t.string "email"
      t.string "password"
      t.timestamps
    end

    create_table "pins", force: true do |t|
      t.belongs_to :user, index: true
      t.string "message"
      t.string "location"
      t.string "recipient", :default => "Public"
      t.string "url"
      t.timestamps
    end
  end
end
