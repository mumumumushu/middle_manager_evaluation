class RemvoePolymorphic < ActiveRecord::Migration[5.0]
  def change
  	remove_reference :evaluations, :user, polymorphic: true,index: true
  	add_reference :evaluations, :user 

  	remove_column :evaluations, :evaluationable_type, :string
  	remove_column :evaluations, :evaluationable_id, :integer
  	add_column :users, :user_type, :string
  	
  end
end
