class CreateRecruitmentEvaluations < ActiveRecord::Migration[6.1]
  def change
    create_table :recruitment_evaluations do |t|
      t.references :recruitment_history, null: false, foreign_key: true
      t.references :recruiter, null: false, foreign_key: true
      t.integer :result
      t.datetime :input_at
      t.text :description

      t.timestamps
    end
  end
end
