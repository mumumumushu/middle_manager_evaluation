class AddUserInfoToSelfEvaluationAndEvaluation < ActiveRecord::Migration[5.0]
  def change
    add_column :self_evaluations, :user_info, :string
  end
end
