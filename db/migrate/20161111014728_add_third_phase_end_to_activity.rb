class AddThirdPhaseEndToActivity < ActiveRecord::Migration[5.0]
  def change
  	add_column :activities, :third_phase_end, :datatime
  end
end
