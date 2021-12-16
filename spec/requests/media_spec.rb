# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Media", type: :request do
  describe "GET /media" do
    before { create_list(:medium, 10) }

    it "メディアの一覧が返却されること" do
      get "/media"
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).length).to eq 10
    end
  end

  describe "POST /media" do

    context "正しいパラメーターが送信された場合" do
      let(:params) do
        {
          medium: {
            name: "Green",
            category: :scout,
          }
        }
      end
      it "新しいメディアの情報が返却されること" do
        post "/media", params: params
        expect(response).to have_http_status(:success)

        json = JSON.parse(response.body)
        expect(json['name']).to eq "Green"
        expect(json['category']).to eq "scout"
      end
    end

    context "パラメータがない状態で送信された場合" do
      it "メディアが作成できない旨が返却されること" do
        post "/media"
        expect(response).to have_http_status(400)
      end
    end
  end

  describe "PUT /media/:id" do
    let!(:medium) { create(:medium, name: "Green", category: :scout) }

    context "メディアが存在する場合" do
      context "正しいパラメーターが送信された場合" do
        let(:params) do
          {
            medium: {
              name: "Wantedly",
              category: :ad,
            }
          }
        end

        it "更新されたメディアの情報が返却されること" do
          put "/media/#{medium.id}", params: params

          expect(response).to have_http_status(:success)

          json = JSON.parse(response.body)
          expect(json['name']).to eq "Wantedly"
          expect(json['category']).to eq "ad"
        end
      end

      context "パラメータがない状態で送信された場合" do
        it "メディアが更新できない旨が返却されること" do
          put "/media/#{medium.id}"

          expect(response).to have_http_status(400)
        end
      end
    end

    context "メディアが存在しない場合" do
      it "メディアが存在しない旨が返却されること" do
        put "/media/#{medium.id + 1 }"

        expect(response).to have_http_status(404)
      end
    end
  end
end
