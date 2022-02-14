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
class Channel < ApplicationRecord
  belongs_to :organization
  delegate :unique_id, to: :organization, prefix: true

  enum category: { agent: 10, ad: 20, scout: 30, sns: 40, referral: 50, other: 60 }, _prefix: true

  validates :name, presence: true
  validates :category, presence: true

  before_save :generate_apply_token

  def automation
    case category.to_sym
    when :agent
      :enable
    when :ad
      :disable
    when :scout
      :disable
    when :sns
      :impossible
    when :referral
      :impossible
    when :other
      :impossible
    end
  end

  def apply_token
    return nil unless category_agent?
    super
  end

  private

  def generate_apply_token
    return if apply_token.present? || !category_agent?

    self.apply_token = loop do
      tmp_token = SecureRandom.alphanumeric(24)
      break tmp_token unless self.class.find_by(apply_token: tmp_token)
    end
  end
end
