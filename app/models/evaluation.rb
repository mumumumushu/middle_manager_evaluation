# == Schema Information
#
# Table name: evaluations
#
#  id                     :integer          not null, primary key
#  thought_morals         :text
#  upright_incorruptiable :text
#  duties                 :text
#  user_type              :string
#  user_id                :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  evaluation_totality    :integer
#

class Evaluation < ApplicationRecord
	
  belongs_to :self_evaluation
  belongs_to :evaluationable, polyphomy: true
end
