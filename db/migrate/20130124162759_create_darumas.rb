class CreateDarumas < ActiveRecord::Migration
  def change
    create_table :darumas do |t|
      t.boolean :right_eye
      t.boolean :left_eye

      t.timestamps
    end
    add_column :darumas, :user_id, :integer
    add_column :darumas, :sender_id, :integer
  end
end
