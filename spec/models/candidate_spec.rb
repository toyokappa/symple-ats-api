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
    let(:candidate) { build :candidate }
    it "有効である" do
      expect(candidate).to be_valid
    end
  end

  describe "Active Storage" do
    let(:candidate) { build :candidate }
    before do
      candidate.resumes.attach(file)
    end

    context "png画像がアップロードされた場合" do
      let(:file) { fixture_file_upload("test_image.png") }

      it "保存される" do
        expect(candidate).to be_valid
      end
    end

    context "jpeg画像がアップロードされた場合" do
      let(:file) { fixture_file_upload("test_image.jpeg") }

      it "保存される" do
        expect(candidate).to be_valid
      end
    end

    context "PDFがアップロードされた場合" do
      let(:file) { fixture_file_upload("test_pdf.pdf") }

      it "保存される" do
        expect(candidate).to be_valid
      end
    end

    context "動画がアップロードされた場合" do
      let(:file) { fixture_file_upload("test_movie.mov") }

      it "形式が異なる旨が返却される" do
        expect(candidate).to be_invalid
      end
    end
  end

  # FIXME: Docker for Macの問題で通過しないテスト
  # describe "#resume_files" do
  #   let(:candidate) { create :candidate }

  #   context "レジュメが存在する場合" do
  #     let(:file) { fixture_file_upload('test_image.png') }
  #     before do
  #       candidate.resumes.attach(file)
  #     end

  #     it "ファイル情報の配列が返却される" do
  #       expect(candidate.resume_files).to eq [
  #         {
  #           id: candidate.resumes.first.id,
  #           name: 'text_image.png',
  #           size: candidate.resumes.first.blob.byte_size,
  #           url: url_for(candidate.resumes.first),
  #         }
  #       ]
  #     end
  #   end

  #   context "レジュメが存在しない場合" do
  #     it "空の配列が返却される" do
  #       expect(candidate.resume_files).to eq []
  #     end
  #   end
  # end

  describe "after_commit" do
    let!(:project) { create :recruitment_project }
    let!(:selections) { create_list :recruitment_selection, 3, recruitment_project: project, selection_type: :interview }
    
    context "第1選考に候補者を登録した場合" do
      let(:candidate) { create :candidate, recruitment_selection: selections[0] }

      it "履歴が1つ作られる" do
        expect(candidate.recruitment_histories.length).to eq 1
        expect(candidate.recruitment_histories[0].result).to eq nil
      end
    end

    context "第2選考に候補者を登録した場合" do
      let(:candidate) { create :candidate, recruitment_selection: selections[1] }

      it "履歴が2つ作られる" do
        expect(candidate.recruitment_histories.length).to eq 2
        expect(candidate.recruitment_histories[0].result).to eq 'pass'
        expect(candidate.recruitment_histories[1].result).to eq nil
      end
    end

    context "第1選考に作られた候補者を第3選考に変更した場合" do
      let(:candidate) { create :candidate, recruitment_selection: selections[0] }

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
      let(:candidate) { create :candidate, recruitment_selection: selections[2] }

      it "履歴の数は変わらない" do
        expect(candidate.recruitment_histories.length).to eq 3

        candidate.update(recruitment_selection: selections[0])
        expect(candidate.recruitment_histories.length).to eq 3
      end
    end

    context "候補者を見送りにした場合" do
      let(:failure_selection) { create :recruitment_selection, recruitment_project: project, selection_type: :failure }
      let(:candidate) { create :candidate, recruitment_selection: selections[0] }

      it "履歴は追加されない" do
        expect(candidate.recruitment_histories.length).to eq 1

        candidate.update(recruitment_selection: failure_selection)
        expect(candidate.recruitment_histories.length).to eq 1
      end
    end

    context "候補者を辞退にした場合" do
      let(:decline_selection) { create :recruitment_selection, recruitment_project: project, selection_type: :decline }
      let(:candidate) { create :candidate, recruitment_selection: selections[1] }

      it "履歴は追加されない" do
        expect(candidate.recruitment_histories.length).to eq 2

        candidate.update(recruitment_selection: decline_selection)
        expect(candidate.recruitment_histories.length).to eq 2
      end
    end
  end
end
