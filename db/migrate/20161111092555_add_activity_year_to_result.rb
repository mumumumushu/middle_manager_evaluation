class AddActivityYearToResult < ActiveRecord::Migration[5.0]
  def change
    add_column :results, :activity_year, :string
  end
end
