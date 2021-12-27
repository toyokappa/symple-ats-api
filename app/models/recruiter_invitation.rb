class RecruiterInvitation < ApplicationRecord
  has_secure_token

  belongs_to :organization

  enum role: { viewer: 10, interviewer: 20, admin: 30 }, _prefix: true
end
