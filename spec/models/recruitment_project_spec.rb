# == Schema Information
#
# Table name: recruitment_projects
#
#  id              :bigint           not null, primary key
#  name            :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  organization_id :bigint
#
require "rails_helper"

RSpec.describe RecruitmentProject, type: :model do
  context "正しい情報がある場合" do
    let(:project) { build(:recruitment_project) }
    it "有効である" do
      expect(project).to be_valid
    end
  end
end
