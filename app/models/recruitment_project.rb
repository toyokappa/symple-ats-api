# == Schema Information
#
# Table name: recruitment_projects
#
#  id         :bigint           not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class RecruitmentProject < ApplicationRecord
  has_many :recruitment_selections, -> { order(:position) }, dependent: :destroy
end
