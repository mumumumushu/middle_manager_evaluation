class AddReferenceToSelfEvaluation < ActiveRecord::Migration[5.0]
  def change
    add_reference :self_evaluations, :activity , forsign_key: true
  end
end
