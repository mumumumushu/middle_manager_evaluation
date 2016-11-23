# == Schema Information
#
# Table name: self_evaluations
#
#  id                       :integer          not null, primary key
#  duties                   :string
#  self_evaluation_totality :string
#  middle_manager_id        :integer
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  created_year             :integer
#  activity_id              :integer
#  user_info                :string
#  evaluated_user_info      :text
#  user_info_id             :integer
#

require 'rails_helper'

RSpec.describe SelfEvaluation, type: :model do
	it { should belong_to(:activity)}
  it { should belong_to(:middle_manager)}
  it { should have_many(:evaluations)}
  it { should have_one(:result)}
end
