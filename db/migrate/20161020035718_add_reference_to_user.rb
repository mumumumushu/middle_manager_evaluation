class AddReferenceToUser < ActiveRecord::Migration[5.0]
  def change
    add_reference :users, :activity, foreign_key: true
  end
end
