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
    name { "MyString" }
    unique_id { "MyString" }
  end
end
