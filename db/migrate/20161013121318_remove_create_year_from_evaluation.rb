class RemoveCreateYearFromEvaluation < ActiveRecord::Migration[5.0]
  def change
    remove_column :evaluations, :create_year, :string
  end
end
