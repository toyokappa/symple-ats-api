class CreateRecruitmentHistories < ActiveRecord::Migration[6.1]
  def change
    create_table :recruitment_histories do |t|
      t.datetime :selected_at, default: -> { 'NOW()' }
      t.integer :result
      t.references :recruitment_selection, null: false, foreign_key: true
      t.references :candidate, null: false, foreign_key: true

      t.timestamps
    end
  end
end
