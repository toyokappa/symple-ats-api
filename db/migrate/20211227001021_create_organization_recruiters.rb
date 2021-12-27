class CreateOrganizationRecruiters < ActiveRecord::Migration[6.1]
  def change
    create_table :organization_recruiters do |t|
      t.references :organization, null: false, foreign_key: true
      t.references :recruiter, null: false, foreign_key: true

      t.timestamps
    end

    add_reference :positions, :organization, index: true
    add_reference :channels, :organization, index: true
    add_reference :recruitment_projects, :organization, index: true
  end
end
