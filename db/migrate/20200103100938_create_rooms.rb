class CreateRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :rooms do |t|
      t.references :item, foreign_key: true
      t.integer :host_user_id
      t.integer :guest_user_id

      t.timestamps
    end
  end
end
