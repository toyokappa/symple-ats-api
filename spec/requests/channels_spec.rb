# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Channels", type: :request do
  describe "GET /channels" do
    before { create_list(:channel, 10) }

    it "チャネルの一覧が返却されること" do
      get "/channels"
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).length).to eq 10
    end
  end

  describe "POST /channels" do

    context "正しいパラメーターが送信された場合" do
      let(:params) do
        {
          channel: {
            name: "Green",
            category: :scout,
          }
        }
      end
      it "新しいチャネルの情報が返却されること" do
        post "/channels", params: params
        expect(response).to have_http_status(:success)

        json = JSON.parse(response.body)
        expect(json['name']).to eq "Green"
        expect(json['category']).to eq "scout"
      end
    end

    context "パラメータがない状態で送信された場合" do
      it "チャネルが作成できない旨が返却されること" do
        post "/channels"
        expect(response).to have_http_status(400)
      end
    end
  end

  describe "PUT /channels/:id" do
    let!(:channel) { create(:channel, name: "Green", category: :scout) }

    context "チャネルが存在する場合" do
      context "正しいパラメーターが送信された場合" do
        let(:params) do
          {
            channel: {
              name: "Wantedly",
              category: :ad,
            }
          }
        end

        it "更新されたチャネルの情報が返却されること" do
          put "/channels/#{channel.id}", params: params

          expect(response).to have_http_status(:success)

          json = JSON.parse(response.body)
          expect(json['name']).to eq "Wantedly"
          expect(json['category']).to eq "ad"
        end
      end

      context "パラメータがない状態で送信された場合" do
        it "チャネルが更新できない旨が返却されること" do
          put "/channels/#{channel.id}"

          expect(response).to have_http_status(400)
        end
      end
    end

    context "チャネルが存在しない場合" do
      it "チャネルが存在しない旨が返却されること" do
        put "/channels/#{channel.id + 1 }"

        expect(response).to have_http_status(404)
      end
    end
  end
end
