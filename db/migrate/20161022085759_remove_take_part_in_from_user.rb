class RemoveTakePartInFromUser < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :take_part_in, :boolean
  end
end
