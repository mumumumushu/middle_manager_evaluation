class AddBeginAtToActivity < ActiveRecord::Migration[5.0]
  def change
    add_column :activities, :begin_at, :datetime
  end
end
