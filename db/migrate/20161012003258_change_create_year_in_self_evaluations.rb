class ChangeCreateYearInSelfEvaluations < ActiveRecord::Migration[5.0]
  def change
  	remove_column :self_evaluations , :create_year  , :string
  	add_column :self_evaluations , :created_year , :integer
  end
end
