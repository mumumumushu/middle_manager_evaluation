class AddCreateYearToSelfEvaluation < ActiveRecord::Migration[5.0]
  def change
    add_column :self_evaluations, :create_year, :string
  end
end
