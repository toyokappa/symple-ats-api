# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Candidates::Positions", type: :request do
  let(:project) { create(:recruitment_project) }
  let(:selections) { create_list(:recruitment_selection, 4, recruitment_project: project) }

  describe "PUT /candidates/:id/position" do
    let!(:candidates) { create_list(:candidate, 3, recruitment_selection: selections[0]) }

    context "候補者が存在する場合" do
      context "順番変更の情報が送信された場合" do
        let(:params) do
          {
            candidate: {
              list_position: 3,
            }
          }
        end

        it "更新された候補者の情報が返却されること" do
          put "/candidates/#{candidates[0].id}/position", params: params

          expect(response).to have_http_status(:success)

          json = JSON.parse(response.body)
          expect(json['listPosition']).to eq 3
        end
      end

      context "選考変更の情報が送信された場合" do
        let(:params) do
          {
            candidate: {
              recruitment_selection_id: selections[1].id,
            }
          }
        end

        it "更新された候補者の情報が返却されること" do
          put "/candidates/#{candidates[1].id}/position", params: params

          expect(response).to have_http_status(:success)

          json = JSON.parse(response.body)
          expect(json['recruitmentSelectionId']).to eq selections[1].id
          expect(json['listPosition']).to eq 1
        end
      end

      context "パラメータがない状態で送信された場合" do
        it "候補者が更新できない旨が返却されること" do
          put "/candidates/#{candidates[0].id}/position"

          expect(response).to have_http_status(400)
        end
      end
    end

    context "候補者が存在しない場合" do
      it "候補者が存在しない旨が返却されること" do
        put "/candidates/#{candidates[2].id + 1 }/position"

        expect(response).to have_http_status(404)
      end
    end
  end
end
