class RemoveCreatedYearFromSelfEvaluation < ActiveRecord::Migration[5.0]
  def change
    remove_column :self_evaluations, :created_year, :integer
  end
end
