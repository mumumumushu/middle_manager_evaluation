class AddActivityYearToActivity < ActiveRecord::Migration[5.0]
  def change
    add_column :activities, :activity_year, :string
  end
end
