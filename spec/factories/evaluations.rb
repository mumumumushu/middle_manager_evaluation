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
#  self_evaluation_id     :integer
#  user_id                :integer
#  already_edited         :boolean          default(FALSE)
#  evaluating_user_type   :string
#  activity_id            :integer
#

FactoryGirl.define do
  # factory :evaluation do
  #   thought_morals "thought_morals"
  #   upright_incorruptiable "upright_incorruptiable"
  #   duties "duties"
  #   evaluation_totality 90
    
  #   created_at '2016-10-2 15:29:57'
  #   updated_at '2016-11-2 15:29:57'
  # end

  factory :evaluation do
    thought_morals '{"思想政治态度":95,"道德作风品行":85,"团结协调合作":75}'
    upright_incorruptiable '{"廉洁从政": 65, "执行党风廉政建设责任制": 55}'
    duties '{"项目1":80,"项目2":70,"项目3":60,"项目4":90}'
    evaluation_totality 90
    
    created_at '2016-10-2 15:29:57'
    updated_at '2016-11-2 15:29:57'
  end

end
