class CreateUserInfos < ActiveRecord::Migration[5.0]
  def change
    create_table :user_infos do |t|
      t.string :name
      t.references :user, foreign_key: true
      t.string :sex
      t.string :date_of_birth
      t.string :politics_status
      t.string :degree_of_education
      t.string :department_and_duty
      t.string :job
      t.string :starting_time_for_the_present_job


      t.timestamps
    end

    remove_column :users, :user_info, :string
  end
end
