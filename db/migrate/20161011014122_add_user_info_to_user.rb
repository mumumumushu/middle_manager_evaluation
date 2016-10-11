class AddUserInfoToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :user_info, :text
  end
end
