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
#

require 'rails_helper'

RSpec.describe Evaluation, type: :model do
   it { should belong_to(:user)}
   it { should belong_to(:self_evaluation)}
end
