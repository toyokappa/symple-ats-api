# == Schema Information
#
# Table name: candidates
#
#  id                       :bigint           not null, primary key
#  name                     :string(255)
#  list_position            :integer
#  recruitment_selection_id :bigint           not null
#  recruiter_id             :bigint
#  medium_id                :bigint
#  position_id              :bigint
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#
require "rails_helper"

RSpec.describe Candidate, type: :model do
  context "正しい情報がある場合" do
    let(:candidate) { build(:candidate) }
    it "有効である" do
      expect(candidate).to be_valid
    end
  end
end
