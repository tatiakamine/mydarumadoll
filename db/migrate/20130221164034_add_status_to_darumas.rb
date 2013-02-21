class AddStatusToDarumas < ActiveRecord::Migration
  def change
    add_column :darumas, :status, :integer
  end
end
