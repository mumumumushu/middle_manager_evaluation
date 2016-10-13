class AddFinalResultToResult < ActiveRecord::Migration[5.0]
  def change
    add_column :results, :final_result, :string
  end
end
