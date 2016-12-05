class ChangeDutiesFromSpringToText < ActiveRecord::Migration[5.0]
  def change
  	change_column :self_evaluations, :duties, :text
  	change_column :evaluations, :duties, :text
  end
end
