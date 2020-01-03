class ChangeColumnToItem < ActiveRecord::Migration[5.2]
  def change
    # 変更内容
    def up
      change_column :items, :status, :integer, default: 0
      change_column :items, :price, :integer, default: 0
    end

    # 変更前の状態
    def down
      change_column :items, :status, :string
      change_column :items, :price, :integer
    end
  end
end
