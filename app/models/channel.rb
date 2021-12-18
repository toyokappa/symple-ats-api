# == Schema Information
#
# Table name: channels
#
#  id          :bigint           not null, primary key
#  name        :string(255)
#  category    :integer
#  automation  :integer          default("disable"), not null
#  apply_token :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Channel < ApplicationRecord
  enum category: { agent: 10, ad: 20, scout: 30, sns: 40, referral: 50, other: 60 }, _prefix: true
  enum automation: { disable: 10, enable: 20, impossible: 30 }, _prefix: true
end
