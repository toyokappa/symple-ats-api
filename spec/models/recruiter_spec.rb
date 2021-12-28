# frozen_string_literal: true

# == Schema Information
#
# Table name: recruiters
#
#  id                     :bigint           not null, primary key
#  provider               :string(255)      default("email"), not null
#  uid                    :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  allow_password_change  :boolean          default(FALSE)
#  remember_created_at    :datetime
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#  name                   :string(255)
#  nickname               :string(255)
#  image                  :string(255)
#  email                  :string(255)
#  level                  :integer          default(1)
#  tokens                 :text(65535)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
require "rails_helper"

RSpec.describe Recruiter, type: :model do
  context "正しい情報がある場合" do
    let(:recruiter) { build(:recruiter) }
    it "有効である" do
      expect(recruiter).to be_valid
    end
  end

  describe "#role" do
    let(:organization) { create(:organization) }
    let(:recruiter) { create(:recruiter) }
    let!(:organization_recruiter) { create(:organization_recruiter, organization: organization, recruiter: recruiter, role: :admin) }

    it "該当の組織の権限が返却される" do
      expect(recruiter.role(organization)).to eq 'admin'
    end
  end
end
