class AddDetailToEvaluation < ActiveRecord::Migration[5.0]
  def change
  	remove_column :evaluations, :user_type , :string
    add_reference :evaluations, :user, polymorphic: true
  end
end
