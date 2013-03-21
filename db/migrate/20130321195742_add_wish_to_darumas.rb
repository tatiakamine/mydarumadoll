class AddWishToDarumas < ActiveRecord::Migration
  def change
    add_column :darumas, :wish, :string
  end
end
