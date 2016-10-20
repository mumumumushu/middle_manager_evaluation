class AddEvaluatedUserInfoToSelfEvaluation < ActiveRecord::Migration[5.0]
  def change
    add_column :self_evaluations, :evaluated_user_info, :text
  end
end
