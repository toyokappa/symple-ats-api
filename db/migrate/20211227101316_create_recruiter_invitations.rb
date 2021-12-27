class CreateRecruiterInvitations < ActiveRecord::Migration[6.1]
  def change
    create_table :recruiter_invitations do |t|
      t.string :email
      t.integer :role
      t.string :token
      t.datetime :expired_at
      t.references :organization, null: false, foreign_key: true

      t.timestamps
    end

    add_index :recruiter_invitations, :token, unique: true
  end
end
