# == Schema Information
#
# Table name: organization_recruiters
#
#  id              :bigint           not null, primary key
#  organization_id :bigint           not null
#  recruiter_id    :bigint           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
require 'rails_helper'

RSpec.describe OrganizationRecruiter, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
