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
FactoryBot.define do
  factory :organization do
    sequence(:name) {|n| "シンプル#{n}株式会社" }
    sequence(:unique_id) {|n| "sym_ple-#{n}" }
  end
end
