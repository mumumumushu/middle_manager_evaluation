class CreateSelfEvaluations < ActiveRecord::Migration[5.0]
  def change
    create_table :self_evaluations do |t|
      t.string :duties
      t.string :self_evaluation_totality
      t.references :middle_manager, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
