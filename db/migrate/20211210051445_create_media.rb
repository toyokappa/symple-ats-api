class CreateMedia < ActiveRecord::Migration[6.1]
  def change
    create_table :media do |t|
      t.string :name
      t.integer :category
      t.integer :automation, default: 10, null: false
      t.string :apply_token

      t.timestamps
    end
  end
end
