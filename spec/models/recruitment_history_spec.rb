# == Schema Information
#
# Table name: recruitment_histories
#
#  id                       :bigint           not null, primary key
#  selected_at              :datetime
#  result                   :integer
#  recruitment_selection_id :bigint           not null
#  candidate_id             :bigint           not null
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#
require "rails_helper"

RSpec.describe RecruitmentHistory, type: :model do
  context "正しい情報がある場合" do
    let(:history) { build(:recruitment_history) }
    it "有効である" do
      expect(history).to be_valid
    end
  end

  describe "#update_auto_scheduling_token" do
    let(:history) { create :recruitment_history }
    it "スケジュール調整用のトークンが作成される" do
      expect(history.auto_scheduling_token.present?).to eq false
      history.update_auto_scheduling_token
      expect(history.auto_scheduling_token.present?).to eq true
    end
  end
end
