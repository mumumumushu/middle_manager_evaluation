class AddUserInfoIdToSelfEvaluation < ActiveRecord::Migration[5.0]
  def change
    add_column :self_evaluations, :user_info_id, :integer
  end
end
