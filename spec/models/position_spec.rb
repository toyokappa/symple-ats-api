# frozen_string_literal: true

# == Schema Information
#
# Table name: positions
#
#  id              :bigint           not null, primary key
#  internal_name   :string(255)
#  external_name   :string(255)
#  status          :integer          default("open")
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  organization_id :bigint
#
require "rails_helper"

RSpec.describe Position, type: :model do
  context "正しい情報がある場合" do
    let(:position) { build(:position) }
    it "有効である" do
      expect(position).to be_valid
    end
  end
end
