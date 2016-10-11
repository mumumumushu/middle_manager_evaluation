class RemoveReferenceUserInEvaluation < ActiveRecord::Migration[5.0]
  def change
  	remove_reference :evaluations , :user 
  end
end
