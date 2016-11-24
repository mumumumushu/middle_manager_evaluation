class AddJobNumToUserInfo < ActiveRecord::Migration[5.0]
  def change
  	add_column :user_infos, :job_num, :string
  end
end
