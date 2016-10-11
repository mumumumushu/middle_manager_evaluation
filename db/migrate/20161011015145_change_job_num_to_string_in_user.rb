class ChangeJobNumToStringInUser < ActiveRecord::Migration[5.0]
  def change
  	change_column  :users , :job_num , :string
  end
end
