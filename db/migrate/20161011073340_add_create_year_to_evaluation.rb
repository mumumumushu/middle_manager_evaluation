class AddCreateYearToEvaluation < ActiveRecord::Migration[5.0]
  def change
    add_column :evaluations, :create_year, :string
  end
end
