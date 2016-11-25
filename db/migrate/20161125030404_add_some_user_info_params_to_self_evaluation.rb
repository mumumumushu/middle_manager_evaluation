class AddSomeUserInfoParamsToSelfEvaluation < ActiveRecord::Migration[5.0]
  def change
  	add_column :self_evaluations, :department_and_duty, :string
  	add_column :self_evaluations, :job, :string
  end
end
