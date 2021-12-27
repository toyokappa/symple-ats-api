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
require 'rails_helper'

RSpec.describe Organization, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
