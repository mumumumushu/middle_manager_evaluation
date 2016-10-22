class AddTakePartInToUserInfo < ActiveRecord::Migration[5.0]
  def change
    add_column :user_infos, :take_part_in, :boolean, default: :false
  end
end
