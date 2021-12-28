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
end
