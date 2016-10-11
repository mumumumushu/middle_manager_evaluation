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

require 'rails_helper'

RSpec.describe Evaluation, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
