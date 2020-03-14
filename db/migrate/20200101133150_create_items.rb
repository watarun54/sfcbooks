class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :title
      t.integer :status, default: 0
      t.integer :price, default: 0
      t.string :lecture
      t.string :teacher
      t.text :memo

      t.timestamps
    end
  end
end
