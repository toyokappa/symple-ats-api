class RecruiterInvitation < ApplicationRecord
  EXPIRED_DATE = 2.days

  has_secure_token

  belongs_to :organization

  enum role: { viewer: 10, interviewer: 20, admin: 30 }, _prefix: true

  before_create :set_expired_at

  private

  def set_expired_at
    self.expired_at = Time.current + EXPIRED_DATE
  end
end
