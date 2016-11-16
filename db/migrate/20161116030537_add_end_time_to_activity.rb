class AddEndTimeToActivity < ActiveRecord::Migration[5.0]
  def change
  	add_column :activities, :first_phase_end, :datetime 
  	add_column :activities, :second_phase_end, :datetime 
  end
end
