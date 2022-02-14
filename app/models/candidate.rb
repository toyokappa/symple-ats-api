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
  include Rails.application.routes.url_helpers

  has_many :recruitment_histories, dependent: :destroy
  belongs_to :recruitment_selection
  belongs_to :recruiter, optional: true
  belongs_to :channel, optional: true
  belongs_to :position, optional: true
  has_one :recruitment_project, through: :recruitment_selection

  has_many_attached :resumes

  validates :resumes, content_type: ['image/png', 'image/jpg', 'image/jpeg', 'application/pdf']

  acts_as_list scope: :recruitment_selection, column: :list_position

  attr_accessor :agent_name, :agent_email, :description

  after_commit :create_or_update_recruitment_histories, if: :persisted?

  def resume_files
    if resumes.attached?
      resumes.map do |resume|
        blob = resume.blob
        {
          id: resume.id,
          name: blob.filename.to_s,
          size: blob.byte_size,
          url: url_for(resume),
        }
      end
    else
      []
    end
  end

  private

  def create_or_update_recruitment_histories
    # 見送り、辞退の場合は直前の履歴は作成しないようにする
    return if recruitment_selection.selection_type.to_sym.in? %i[failure decline]

    add_history_selections = recruitment_project.recruitment_selections.where(position: ..recruitment_selection.position)

    RecruitmentHistory.transaction do
      add_history_selections.each.with_index(1) do |selection, index|
        history = recruitment_histories.find_or_initialize_by(recruitment_selection: selection)
        # 自動で直前の選考まで合格ステータスとなる
        history.result = :pass if index < add_history_selections.length
        history.save!
      end
    end
  end
end
