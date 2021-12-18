# frozen_string_literal: true

require "rails_helper"

RSpec.describe "RecruitmentSelection", type: :request do
  describe "GET /recruitment_selections" do
    before { create_list(:recruitment_selection, 10) }

    it "採用選考の一覧が返却されること" do
      get "/recruitment_selections"
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).length).to eq 10
    end
  end
end
