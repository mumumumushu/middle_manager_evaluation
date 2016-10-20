class AddTakePartInToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :take_part_in, :boolean, default: :true
  end
end
