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
#

FactoryGirl.define do
  factory :self_evaluation do
    duties "MyString"
    self_evaluation_totality "MyString"
    middle_manager nil
  end
end
