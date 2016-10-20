class AddEvaluatingUserTypeToEvaluation < ActiveRecord::Migration[5.0]
  def change
    add_column :evaluations, :evaluating_user_type, :string
  end
end
