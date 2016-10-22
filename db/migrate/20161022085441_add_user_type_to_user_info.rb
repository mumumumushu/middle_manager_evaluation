class AddUserTypeToUserInfo < ActiveRecord::Migration[5.0]
  def change
    add_column :user_infos, :user_type, :string
  end
end
