class AddActivityIdToEvaluation < ActiveRecord::Migration[5.0]
  def change
    add_column :evaluations, :activity_id, :integer
  end
end
