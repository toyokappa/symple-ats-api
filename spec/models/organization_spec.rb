# == Schema Information
#
# Table name: organizations
#
#  id         :bigint           not null, primary key
#  name       :string(255)
#  unique_id  :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Organization, type: :model do
  context "正しい情報がある場合" do
    let(:organization) { build(:organization) }
    it "有効である" do
      expect(organization).to be_valid
    end
  end

  context "name空場合" do
    let(:organization) { build(:organization, name: nil) }

    it "無効である" do
      expect(organization).to be_invalid
      expect(organization.errors[:name]).to include("を入力してください")
    end
  end

  context "unique_idが空の場合" do
    let(:organization) { build(:organization, unique_id: nil) }

    it "無効である" do
      expect(organization).to be_invalid
      expect(organization.errors[:unique_id]).to include("を入力してください")
    end
  end

  context "unique_idが指定外文字の場合" do
    let(:organization) { build(:organization, unique_id: "uni#{'A./&?!#'.split('').sample}que") }

    it "無効である" do
      expect(organization).to be_invalid
      expect(organization.errors[:unique_id]).to include("は不正な値です")
    end
  end

  context "存在するunique_idが指定された場合" do
    before { create(:organization, unique_id: 'unique') }
    let(:organization) { build(:organization, unique_id: 'unique') }

    it "無効である" do
      expect(organization).to be_invalid
      expect(organization.errors[:unique_id]).to include("はすでに存在します")
    end
  end
end
