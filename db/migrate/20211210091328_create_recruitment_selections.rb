class CreateRecruitmentSelections < ActiveRecord::Migration[6.1]
  def change
    create_table :recruitment_selections do |t|
      t.string :name
      t.integer :position

      t.references :recruitment_project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
