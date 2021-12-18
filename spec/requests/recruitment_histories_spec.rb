# frozen_string_literal: true

require "rails_helper"

RSpec.describe "RecruitmentHistories", type: :request do
  let(:project) { create(:recruitment_project) }
  let(:selection) { create(:recruitment_selection, recruitment_project: project) }
  let(:candidate) { create(:candidate, recruitment_selection: selection) }

  describe "PUT /recruitment_histories/:id" do
    context "選考履歴が存在する場合" do
      context "正しいパラメータが送信された場合" do
        let(:params) do
          {
            history: {
              result: :pass,
              selected_at: Time.zone.parse('2021-12-28')
            }
          }
        end

        it "更新された選考履歴の情報が返却されること" do
          put "/recruitment_histories/#{candidate.recruitment_histories[0].id}", params: params

          expect(response).to have_http_status(:success)

          json = JSON.parse(response.body)
          expect(json['result']).to eq 'pass'
          expect(json['selectedAt']).to eq Time.zone.parse('2021-12-28').to_s
        end
      end

      context "パラメータがない状態で送信された場合" do
        it "候補者が更新できない旨が返却されること" do
          put "/recruitment_histories/#{candidate.recruitment_histories[0].id}"

          expect(response).to have_http_status(400)
        end
      end
    end

    context "候補者が存在しない場合" do
      it "候補者が存在しない旨が返却されること" do
        put "/recruitment_histories/#{candidate.recruitment_histories[0].id + 1 }"

        expect(response).to have_http_status(404)
      end
    end
  end
end
