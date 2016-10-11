class CreateActivities < ActiveRecord::Migration[5.0]
  def change
    create_table :activities do |t|
      t.datetime :first_phase_begin
      t.datetime :second_phase_begin
      t.datetime :third_phase_begin

      t.timestamps
    end
  end
end
