class AddAlreadyEditedToEvaluation < ActiveRecord::Migration[5.0]
  def change
    add_column :evaluations, :already_edited, :boolean, defalut: :false
    change_column :users, :take_part_in, :boolean, default: :false
  end
end
