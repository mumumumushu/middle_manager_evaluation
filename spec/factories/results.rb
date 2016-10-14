# == Schema Information
#
# Table name: results
#
#  id                 :integer          not null, primary key
#  self_evaluation_id :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  final_result       :string
#

FactoryGirl.define do
  factory :result do
  	final_result '基本称职'
    #self_evaluation nil
  end
end
