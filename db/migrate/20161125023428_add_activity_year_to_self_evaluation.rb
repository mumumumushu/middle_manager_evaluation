class AddActivityYearToSelfEvaluation < ActiveRecord::Migration[5.0]
  def change
    add_column :self_evaluations, :activity_year, :string
  end
end
