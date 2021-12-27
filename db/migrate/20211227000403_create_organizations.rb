class CreateOrganizations < ActiveRecord::Migration[6.1]
  def change
    create_table :organizations do |t|
      t.string :name
      t.string :unique_id

      t.timestamps
    end

    add_index :organizations, :unique_id, unique: true
  end
end
