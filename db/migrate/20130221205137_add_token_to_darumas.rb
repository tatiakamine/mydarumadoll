class AddTokenToDarumas < ActiveRecord::Migration
  def change
    add_column :darumas, :token, :string
  end
end
