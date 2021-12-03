class CreatePositions < ActiveRecord::Migration[6.1]
  def change
    create_table :positions do |t|
      t.string :internal_name
      t.string :external_name
      t.integer :status, default: 10

      t.timestamps
    end
  end
end
