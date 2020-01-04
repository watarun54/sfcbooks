class AddImgToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :img1, :string
    add_column :items, :img2, :string
    add_column :items, :img3, :string
  end
end
