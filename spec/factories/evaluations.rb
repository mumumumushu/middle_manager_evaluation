# == Schema Information
#
# Table name: evaluations
#
#  id                     :integer          not null, primary key
#  thought_morals         :text
#  upright_incorruptiable :text
#  duties                 :text
#  evaluation             :integer
#  user_type              :string
#  user_id                :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
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
