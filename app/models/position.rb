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
class Position < ApplicationRecord
  belongs_to :organization

  enum status: { open: 10, close: 20 }, _prefix: true

  validates :internal_name, presence: true
  validates :external_name, presence: true
end
