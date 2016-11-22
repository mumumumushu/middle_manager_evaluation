class ChangeColumnTakePartInFromBooleanToString < ActiveRecord::Migration[5.0]
  def change
  	change_column :users, :take_part_in, :string 
  end
end
