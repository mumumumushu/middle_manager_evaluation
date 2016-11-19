class AddFinalEvaluationTimeToResult < ActiveRecord::Migration[5.0]
  def change
    add_column :results, :final_evaluation_time, :datetime
  end
end
