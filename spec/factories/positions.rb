# frozen_string_literal: true

# == Schema Information
#
# Table name: positions
#
#  id            :bigint           not null, primary key
#  internal_name :string(255)
#  external_name :string(255)
#  status        :integer          default("open")
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
FactoryBot.define do
  factory :position do
    sequence(:internal_name) {|n| "ポジション#{n}" }
    sequence(:external_name) {|n| "エンジニアポジション#{n}" }
    status { [10, 20].sample }
  end
end
