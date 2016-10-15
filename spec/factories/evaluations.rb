# == Schema Information
#
# Table name: evaluations
#
#  id                     :integer          not null, primary key
#  thought_morals         :text
#  upright_incorruptiable :text
#  duties                 :text
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  evaluation_totality    :integer
#  evaluationable_type    :string
#  evaluationable_id      :integer
#  create_year            :string
#  self_evaluation_id     :integer
#

FactoryGirl.define do
  factory :evaluation do
    thought_morals "thought_morals"
    upright_incorruptiable "upright_incorruptiable"
    duties "duties"
    evaluation_totality 90

    # evaluation 1
    
    created_at '2016-10-2 15:29:57'
    updated_at '2016-11-2 15:29:57'

    association :evaluationable
    # self_evaluation_id
    # evaluationable_type staff || middle_manager || leader

  end
end
