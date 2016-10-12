class RemoveBeginAtFromActivity < ActiveRecord::Migration[5.0]
  def change
    remove_column :activities, :begin_at, :datetime
  end
end
