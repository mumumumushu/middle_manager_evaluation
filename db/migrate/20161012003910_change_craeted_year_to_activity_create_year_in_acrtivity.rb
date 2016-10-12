class ChangeCraetedYearToActivityCreateYearInAcrtivity < ActiveRecord::Migration[5.0]
  def change
  	remove_column :activities , :created_year , :integer
  	add_column :activities , :activity_created_year , :integer
  end
end
