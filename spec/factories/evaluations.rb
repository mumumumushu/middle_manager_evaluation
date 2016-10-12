# == Schema Information
#
# Table name: evaluations
#
#  id                     :integer          not null, primary key
#  thought_morals         :text
#  upright_incorruptiable :text
#  duties                 :text
#  user_type              :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  evaluation_totality    :integer
#  evaluationable_type    :string
#  evaluationable_id      :integer
#  create_year            :string
#

FactoryGirl.define do
  factory :evaluation do
    thought_morals "MyText"
    upright_incorruptiable "MyText"
    duties "MyText"
    evaluation 1
    user nil
  end
end
