# == Schema Information
#
# Table name: candidates
#
#  id                       :bigint           not null, primary key
#  name                     :string(255)
#  list_position            :integer
#  recruitment_selection_id :bigint           not null
#  recruiter_id             :bigint
#  channel_id               :bigint
#  position_id              :bigint
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#
class Candidate < ApplicationRecord
  has_many :recruitment_histories, dependent: :destroy
  belongs_to :recruitment_selection
  belongs_to :recruiter, optional: true
  belongs_to :channel, optional: true
  belongs_to :position, optional: true
  has_one :recruitment_project, through: :recruitment_selection

  acts_as_list scope: :recruitment_selection, column: :list_position

  before_save {
    add_history_selections = recruitment_project.recruitment_selections.where(position: ..recruitment_selection.position)

    add_history_selections.each do |selection|
      recruitment_histories.find_or_initialize_by(recruitment_selection: selection)
    end
  }
end
