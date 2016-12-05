# == Schema Information
#
# Table name: self_evaluations
#
#  id                       :integer          not null, primary key
#  duties                   :text
#  self_evaluation_totality :string
#  middle_manager_id        :integer
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  created_year             :integer
#  activity_id              :integer
#  user_info                :string
#  evaluated_user_info      :text
#  user_info_id             :integer
#  activity_year            :string
#  department_and_duty      :string
#  job                      :string
#

require 'rails_helper'

RSpec.describe SelfEvaluation, type: :model do
	it { should belong_to(:activity)}
  it { should belong_to(:middle_manager)}
  it { should have_many(:evaluations)}
  it { should have_one(:result)}
end
