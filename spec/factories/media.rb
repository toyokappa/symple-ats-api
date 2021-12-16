# frozen_string_literal: true

# == Schema Information
#
# Table name: media
#
#  id          :bigint           not null, primary key
#  name        :string(255)
#  category    :integer
#  automation  :integer          default("disable"), not null
#  apply_token :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
FactoryBot.define do
  factory :medium do
    sequence(:name) {|n| "メディア#{n}" }
    category { [10, 20, 30, 40, 50, 60].sample }
    automation { [10, 20, 30].sample }
  end
end
