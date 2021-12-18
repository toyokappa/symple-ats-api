# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Position", type: :request do
  describe "GET /positions" do
    before { create_list(:position, 10) }

    it "ポジションの一覧が返却されること" do
      get "/positions"
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).length).to eq 10
    end
  end

  describe "POST /positions" do

    context "正しいパラメーターが送信された場合" do
      let(:params) do
        {
          position: {
            internal_name: "エンジニア",
            external_name: "テックリードを目指したいエンジニア",
          }
        }
      end
      it "新しいポジションの情報が返却されること" do
        post "/positions", params: params
        expect(response).to have_http_status(:success)

        json = JSON.parse(response.body)
        expect(json['internalName']).to eq "エンジニア"
        expect(json['externalName']).to eq "テックリードを目指したいエンジニア"
      end
    end

    context "パラメータがない状態で送信された場合" do
      it "ポジションが作成できない旨が返却されること" do
        post "/positions"
        expect(response).to have_http_status(400)
      end
    end
  end

  describe "PUT /positions/:id" do
    let!(:position) { create(:position, internal_name: "エンジニア", external_name: "テックリードを目指したいエンジニア") }

    context "ポジションが存在する場合" do
      context "正しいパラメーターが送信された場合" do
        let(:params) do
          {
            position: {
              internal_name: "デザイナー",
              external_name: "サービス設計がしたいデザイナー",
              status: :close,
            }
          }
        end

        it "更新されたポジションの情報が返却されること" do
          put "/positions/#{position.id}", params: params

          expect(response).to have_http_status(:success)

          json = JSON.parse(response.body)
          expect(json['internalName']).to eq "デザイナー"
          expect(json['externalName']).to eq "サービス設計がしたいデザイナー"
          expect(json['status']).to eq "close"
        end
      end

      context "パラメータがない状態で送信された場合" do
        it "ポジションが更新できない旨が返却されること" do
          put "/positions/#{position.id}"

          expect(response).to have_http_status(400)
        end
      end
    end

    context "ポジションが存在しない場合" do
      it "ポジションが存在しない旨が返却されること" do
        put "/positions/#{position.id + 1 }"

        expect(response).to have_http_status(404)
      end
    end
  end
end
