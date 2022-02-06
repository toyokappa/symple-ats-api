class CreateRecruitmentHistories < ActiveRecord::Migration[6.1]
  def change
    create_table :recruitment_histories do |t|
      t.datetime :selected_at
      t.integer :result
      t.string :auto_scheduling_token
      t.references :recruitment_selection, null: false, foreign_key: true
      t.references :candidate, null: false, foreign_key: true

      t.timestamps

      t.index :auto_scheduling_token, unique: true
    end
  end
end
