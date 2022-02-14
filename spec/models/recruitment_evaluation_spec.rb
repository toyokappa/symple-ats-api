require 'rails_helper'

RSpec.describe RecruitmentEvaluation, type: :model do
  context "正しい情報がある場合" do
    let(:evaluation) { build(:recruitment_evaluation) }
    it "有効である" do
      expect(evaluation).to be_valid
    end
  end
end
