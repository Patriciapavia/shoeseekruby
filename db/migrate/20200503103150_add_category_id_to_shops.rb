class AddCategoryIdToShops < ActiveRecord::Migration[6.0]
  def change
    add_column :shops, :category_id, :integer
  end
end
