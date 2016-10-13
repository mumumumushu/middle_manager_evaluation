# == Schema Information
#
# Table name: results
#
#  id                 :integer          not null, primary key
#  self_evaluation_id :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

require 'rails_helper'

RSpec.describe Result, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
