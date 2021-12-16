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
class Position < ApplicationRecord
  enum status: { open: 10, close: 20 }, _prefix: true
end
