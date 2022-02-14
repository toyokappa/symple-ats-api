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

  describe "chart" do
    let(:project) { create :recruitment_project }
    before do
      create :recruitment_selection, recruitment_project: project, selection_type: :document, name: '書類選考'
      create :recruitment_selection, recruitment_project: project, selection_type: :interview, name: '1次面接'
      create :recruitment_selection, recruitment_project: project, selection_type: :interview, name: '2次面接'
      create :recruitment_selection, recruitment_project: project, selection_type: :offer, name: '内定'
      create :recruitment_selection, recruitment_project: project, selection_type: :consent, name: '内定承諾'
      create :recruitment_selection, recruitment_project: project, selection_type: :failure, name: '見送り'
      create :recruitment_selection, recruitment_project: project, selection_type: :decline, name: '辞退'
      create :recruitment_selection, recruitment_project: project, selection_type: :other, name: 'その他'
    end

    describe "#chart_labels" do
      it "グラフのラベルが返却される" do
        expect(project.chart_labels).to eq ['書類選考', '1次面接', '2次面接', '内定', '内定承諾', '']
      end
    end

    describe "#chart_values" do
      # TODO: ロジックが複雑なので後回し
    end

    describe "#to_table_headers" do
      # TODO: ロジックが複雑なので後回し
    end

    describe "#to_table_values" do
      # TODO: ロジックが複雑なので後回し
    end

    describe "#chart_json" do
      # TODO: ロジックが複雑なので後回し
    end
  end
end
