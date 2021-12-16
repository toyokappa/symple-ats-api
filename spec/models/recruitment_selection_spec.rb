# == Schema Information
#
# Table name: recruitment_selections
#
#  id                     :bigint           not null, primary key
#  name                   :string(255)
#  selection_type         :integer
#  position               :integer
#  recruitment_project_id :bigint           not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
require "rails_helper"

RSpec.describe RecruitmentSelection, type: :model do
  context "正しい情報がある場合" do
    let(:selection) { build(:recruitment_selection) }
    it "有効である" do
      expect(selection).to be_valid
    end
  end
end
