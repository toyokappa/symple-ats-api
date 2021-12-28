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
require 'rails_helper'

RSpec.describe RecruiterInvitation, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
