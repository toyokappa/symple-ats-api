# == Schema Information
#
# Table name: recruiter_invitations
#
#  id              :bigint           not null, primary key
#  email           :string(255)
#  role            :integer
#  token           :string(255)
#  expired_at      :datetime
#  organization_id :bigint           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
require 'rails_helper'

RSpec.describe RecruiterInvitation, type: :model do
  context "正しい情報がある場合" do
    let(:invitation) { build(:recruiter_invitation) }
    it "有効である" do
      expect(invitation).to be_valid
    end
  end

  context "emailが空の場合" do
    let(:invitation) { build(:recruiter_invitation, email: nil) }

    it "無効である" do
      expect(invitation).to be_invalid
      expect(invitation.errors[:email]).to include("を入力してください")
    end
  end

  context "emailが指定文字以外の場合" do
    let(:invitation) { build(:recruiter_invitation, email: 'hoge') }

    it "無効である" do
      expect(invitation).to be_invalid
      expect(invitation.errors[:email]).to include("は不正な値です")
    end
  end

  context "招待中のemailが指定された場合" do
    before { create(:recruiter_invitation, email: 'test@symple.com', organization: organization) } 
    let(:organization) { create(:organization) }
    let(:invitation) { build(:recruiter_invitation, email: 'test@symple.com', organization: organization) }

    it "無効である" do
      expect(invitation).to be_invalid
      expect(invitation.errors[:email]).to include("はすでに存在します")
    end
  end

  context "別組織で招待中のemailが指定された場合" do
    before { create(:recruiter_invitation, email: 'test@symple.com') } 
    let(:invitation) { build(:recruiter_invitation, email: 'test@symple.com') }

    it "有効である" do
      expect(invitation).to be_valid
    end
  end

  context "すでに所属するemailが指定された場合" do
    before do
      recruiter = create(:recruiter, email: 'test@symple.com')
      create(:organization_recruiter, organization: organization, recruiter: recruiter)
    end
    let(:organization) { create(:organization) }
    let(:invitation) { build(:recruiter_invitation, email: 'test@symple.com', organization: organization) }

    it "無効である" do
      expect(invitation).to be_invalid
      expect(invitation.errors[:email]).to include("はすでに存在します")
    end
  end

  context "別組織ですでに所属するemailが指定された場合" do
    before do
      recruiter = create(:recruiter, email: 'test@symple.com')
      create(:organization_recruiter, recruiter: recruiter)
    end
    let(:invitation) { build(:recruiter_invitation, email: 'test@symple.com') }

    it "有効である" do
      expect(invitation).to be_valid
    end
  end

  context "roleが空の場合" do
    let(:invitation) { build(:recruiter_invitation, role: nil) }

    it "無効である" do
      expect(invitation).to be_invalid
      expect(invitation.errors[:role]).to include("を入力してください")
    end
  end

  describe "before_create" do
    let(:invitation) { build(:recruiter_invitation) }

    it "自動で有効期限が設定される" do
      travel_to Time.zone.parse('2022-01-01') do
        invitation.save
        expect(invitation.expired_at).to eq Time.zone.parse('2022-01-03')
      end
    end
  end
end
