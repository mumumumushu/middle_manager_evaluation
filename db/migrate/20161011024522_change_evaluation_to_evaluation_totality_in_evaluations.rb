class ChangeEvaluationToEvaluationTotalityInEvaluations < ActiveRecord::Migration[5.0]
  def change
  	remove_column :evaluations, :evaluation, :integer
  	add_column :evaluations, :evaluation_totality, :integer
  end
end
