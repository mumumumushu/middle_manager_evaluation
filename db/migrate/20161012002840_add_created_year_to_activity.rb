class AddCreatedYearToActivity < ActiveRecord::Migration[5.0]
  def change
    add_column :activities, :created_year, :integer
  end
end
