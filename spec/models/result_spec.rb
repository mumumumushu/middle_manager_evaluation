# == Schema Information
#
# Table name: results
#
#  id                 :integer          not null, primary key
#  self_evaluation_id :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  final_result       :string
#  activity_year      :string
#

require 'rails_helper'

RSpec.describe Result, type: :model do
  it { should belong_to( :self_evaluation ) }
end
