class CreateCandidates < ActiveRecord::Migration[6.1]
  def change
    create_table :candidates do |t|
      t.string :name
      t.integer :list_position
      t.references :recruitment_selection, null: false, foreign_key: true
      t.bigint :recruiter_id
      t.bigint :channel_id
      t.bigint :position_id

      t.timestamps
    end

    add_index :candidates, :recruiter_id
    add_index :candidates, :channel_id
    add_index :candidates, :position_id
  end
end
