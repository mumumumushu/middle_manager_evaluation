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

require 'rails_helper'

RSpec.describe Evaluation, type: :model do
   it { should belong_to(:evaluationable)}
end
