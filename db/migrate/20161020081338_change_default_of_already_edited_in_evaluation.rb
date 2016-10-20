class ChangeDefaultOfAlreadyEditedInEvaluation < ActiveRecord::Migration[5.0]
  def change
  	change_column :evaluations, :already_edited, :boolean, default: :false
  end
end
