class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :title
      t.string :status
      t.integer :price
      t.string :lecture
      t.string :teacher
      t.text :memo

      t.timestamps
    end
  end
end
