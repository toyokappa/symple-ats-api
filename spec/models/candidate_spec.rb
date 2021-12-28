# == Schema Information
#
# Table name: candidates
#
#  id                       :bigint           not null, primary key
#  name                     :string(255)
#  list_position            :integer
#  recruitment_selection_id :bigint           not null
#  recruiter_id             :bigint
#  channel_id               :bigint
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

  describe "after_commit" do
    let!(:project) { create(:recruitment_project) }
    let!(:selections) { create_list(:recruitment_selection, 3, recruitment_project: project, selection_type: :interview) }
    
    context "第1選考に候補者を登録した場合" do
      let(:candidate) { create(:candidate, recruitment_selection: selections[0]) }

      it "履歴が1つ作られる" do
        expect(candidate.recruitment_histories.length).to eq 1
        expect(candidate.recruitment_histories[0].result).to eq nil
      end
    end

    context "第2選考に候補者を登録した場合" do
      let(:candidate) { create(:candidate, recruitment_selection: selections[1]) }

      it "履歴が2つ作られる" do
        expect(candidate.recruitment_histories.length).to eq 2
        expect(candidate.recruitment_histories[0].result).to eq 'pass'
        expect(candidate.recruitment_histories[1].result).to eq nil
      end
    end

    context "第1選考に作られた候補者を第3選考に変更した場合" do
      let(:candidate) { create(:candidate, recruitment_selection: selections[0]) }

      it "履歴が1つから3つに増える" do
        expect(candidate.recruitment_histories.length).to eq 1

        candidate.update(recruitment_selection: selections[2])
        candidate.reload

        expect(candidate.recruitment_histories.length).to eq 3
        expect(candidate.recruitment_histories[0].result).to eq 'pass'
        expect(candidate.recruitment_histories[1].result).to eq 'pass'
        expect(candidate.recruitment_histories[2].result).to eq nil
      end
    end

    context "第3選考に作られた候補者を第1選考に変更した場合" do
      let(:candidate) { create(:candidate, recruitment_selection: selections[2]) }

      it "履歴の数は変わらない" do
        expect(candidate.recruitment_histories.length).to eq 3

        candidate.update(recruitment_selection: selections[0])
        expect(candidate.recruitment_histories.length).to eq 3
      end
    end

    context "候補者を見送りにした場合" do
      let(:failure_selection) { create(:recruitment_selection, recruitment_project: project, selection_type: :failure) }
      let(:candidate) { create(:candidate, recruitment_selection: selections[0]) }

      it "履歴は追加されない" do
        expect(candidate.recruitment_histories.length).to eq 1

        candidate.update(recruitment_selection: failure_selection)
        expect(candidate.recruitment_histories.length).to eq 1
      end
    end

    context "候補者を辞退にした場合" do
      let(:decline_selection) { create(:recruitment_selection, recruitment_project: project, selection_type: :decline) }
      let(:candidate) { create(:candidate, recruitment_selection: selections[1]) }

      it "履歴は追加されない" do
        expect(candidate.recruitment_histories.length).to eq 2

        candidate.update(recruitment_selection: decline_selection)
        expect(candidate.recruitment_histories.length).to eq 2
      end
    end
  end
end
