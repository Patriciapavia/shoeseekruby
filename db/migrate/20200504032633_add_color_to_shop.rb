class AddColorToShop < ActiveRecord::Migration[6.0]
  def change
    add_column :shops, :color, :string
  end
end
