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
end
