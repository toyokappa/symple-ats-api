# == Schema Information
#
# Table name: recruiter_invitations
#
#  id              :bigint           not null, primary key
#  email           :string(255)
#  role            :integer
#  token           :string(255)
#  expired_at      :datetime
#  organization_id :bigint           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class RecruiterInvitation < ApplicationRecord
  EXPIRED_DATE = 2.days

  has_secure_token

  belongs_to :organization

  enum role: { viewer: 10, interviewer: 20, admin: 30 }, _prefix: true

  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :email, uniqueness: { scope: :organization_id }
  validate :email_uniqueness_scope_recruiter_same_organization
  validates :role, presence: true

  before_create :set_expired_at

  private

  def email_uniqueness_scope_recruiter_same_organization
    if organization.recruiters.exists?(email: email)
      errors.add(:email, :taken)
    end
  end

  def set_expired_at
    self.expired_at = Time.current + EXPIRED_DATE
  end
end
