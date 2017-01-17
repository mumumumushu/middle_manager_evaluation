class AddAverageLevelBySettingToResult < ActiveRecord::Migration[5.0]
  def change
    add_column :results, :average_level_by_setting, :string
  end
end
