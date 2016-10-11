class ChangeReferenceInRvaluations < ActiveRecord::Migration[5.0]
  def change
  	remove_reference :evaluations , :user 
  	add_reference :evaluations , :evaluationable ,  polymorphic: true, index: true
  	
  end
end
