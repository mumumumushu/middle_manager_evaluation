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

class Result < ApplicationRecord
  belongs_to :self_evaluation

 #enum status: { active: 0, waiting: 1 ,archived: 2 }
  



end
