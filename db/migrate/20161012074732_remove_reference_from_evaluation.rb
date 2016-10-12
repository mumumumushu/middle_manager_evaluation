class RemoveReferenceFromEvaluation < ActiveRecord::Migration[5.0]
  def change
    remove_reference :evaluations, :user, polymorphic: true
  end
end
