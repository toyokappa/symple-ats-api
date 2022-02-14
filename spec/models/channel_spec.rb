# frozen_string_literal: true

# == Schema Information
#
# Table name: channels
#
#  id              :bigint           not null, primary key
#  name            :string(255)
#  category        :integer
#  automation      :integer          default("disable"), not null
#  apply_token     :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  organization_id :bigint
#
require "rails_helper"

RSpec.describe Channel, type: :model do
  context "正しい情報がある場合" do
    let(:channel) { build(:channel) }

    it "有効である" do
      expect(channel).to be_valid
    end
  end

  context "nameが空の場合" do
    let(:channel) { build(:channel, name: nil) }

    it "無効である" do
      expect(channel).to be_invalid
      expect(channel.errors[:name]).to include("を入力してください")
    end
  end

  context "categoryが空の場合" do
    let(:channel) { build(:channel, category: nil) }

    it "無効である" do
      expect(channel).to be_invalid
      expect(channel.errors[:category]).to include("を入力してください")
    end
  end

  describe "#automation" do
    let(:channel) { create :channel, category: category }

    context "categoryがagentの場合" do
      let(:category) { :agent }

      it "enableが返却される" do
        expect(channel.automation).to eq :enable
      end
    end

    context "categoryがadの場合" do
      let(:category) { :ad }

      it "disableが返却される" do
        expect(channel.automation).to eq :disable
      end
    end

    context "categoryがscoutの場合" do
      let(:category) { :scout }

      it "disableが返却される" do
        expect(channel.automation).to eq :disable
      end
    end

    context "categoryがsnsの場合" do
      let(:category) { :sns }

      it "impossibleが返却される" do
        expect(channel.automation).to eq :impossible
      end
    end

    context "categoryがreferalの場合" do
      let(:category) { :referral }

      it "impossibleが返却される" do
        expect(channel.automation).to eq :impossible
      end
    end

    context "categoryがotherの場合" do
      let(:category) { :other }

      it "impossibleが返却される" do
        expect(channel.automation).to eq :impossible
      end
    end
  end

  describe "#apply_token" do
    let(:channel) { create :channel, category: category, apply_token: 'test_token' }

    context "categoryがagentの場合" do
      let(:category) { :agent }

      it "トークンが返却される" do
        expect(channel.apply_token).to eq 'test_token'
      end
    end

    context "categoryがagent以外の場合" do
      let(:category) { :other }

      it "nilが返却される" do
        expect(channel.apply_token).to eq nil
      end
    end
  end
end
