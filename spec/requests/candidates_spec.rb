# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Candidates", type: :request do
  let(:project) { create(:recruitment_project) }
  let(:selections) { create_list(:recruitment_selection, 4, recruitment_project: project) }
  let!(:recruiters) { create_list(:recruiter, 3) }
  let!(:media) { create_list(:medium, 3) }
  let!(:positions) { create_list(:position, 3) }

  describe "POST /candidates" do

    context "正しいパラメーターが送信された場合" do
      let(:params) do
        {
          candidate: {
            name: "シンプル 太郎",
            recruitment_selection_id: selections[0].id,
          }
        }
      end
      it "新しい候補者の情報が返却されること" do
        post "/candidates", params: params
        expect(response).to have_http_status(:success)

        json = JSON.parse(response.body)
        expect(json['name']).to eq "シンプル 太郎"
        expect(json['recruitmentSelectionId']).to eq selections[0].id
      end
    end

    context "パラメータがない状態で送信された場合" do
      it "候補者が作成できない旨が返却されること" do
        post "/candidates"
        expect(response).to have_http_status(400)
      end
    end
  end

  describe "PUT /candidates/:id" do
    let!(:candidate) { create(
      :candidate,
      name: "シンプル 太郎",
      recruitment_selection: selections[0],
      recruiter: recruiters[0],
      medium: media[0],
      position: positions[0],
    ) }

    context "候補者が存在する場合" do
      context "正しいパラメーターが送信された場合" do
        let(:params) do
          {
            candidate: {
              name: "シンプル 次郎",
              recruitment_selection_id: selections[1].id,
              recruiter_id: recruiters[2].id,
              medium_id: media[2].id,
              position_id: positions[2].id,
            }
          }
        end

        it "更新された候補者の情報が返却されること" do
          put "/candidates/#{candidate.id}", params: params

          expect(response).to have_http_status(:success)

          json = JSON.parse(response.body)
          expect(json['name']).to eq "シンプル 次郎"
          expect(json['recruitmentSelectionId']).to eq selections[1].id
          expect(json['recruiter']['id']).to eq recruiters[2].id
          expect(json['medium']['id']).to eq media[2].id
          expect(json['position']['id']).to eq positions[2].id
        end
      end

      context "パラメータがない状態で送信された場合" do
        it "候補者が更新できない旨が返却されること" do
          put "/candidates/#{candidate.id}"

          expect(response).to have_http_status(400)
        end
      end
    end

    context "候補者が存在しない場合" do
      it "候補者が存在しない旨が返却されること" do
        put "/candidates/#{candidate.id + 1 }"

        expect(response).to have_http_status(404)
      end
    end
  end
end
