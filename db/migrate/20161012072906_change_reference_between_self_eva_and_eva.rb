class ChangeReferenceBetweenSelfEvaAndEva < ActiveRecord::Migration[5.0]
  def change
  	remove_reference :evaluations, :self_evaluation, polymorphic: true
  	add_reference :evaluations, :self_evaluation, foreign_key: true

  end
end
