class CreateRecruitmentProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :recruitment_projects do |t|
      t.string :name

      t.timestamps
    end
  end
end
