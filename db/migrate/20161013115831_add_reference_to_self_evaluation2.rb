class AddReferenceToSelfEvaluation2 < ActiveRecord::Migration[5.0]
  def change
    add_column :self_evaluations, :activity, :reference
  end
end
