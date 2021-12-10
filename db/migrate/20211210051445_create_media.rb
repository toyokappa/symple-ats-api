class CreateMedia < ActiveRecord::Migration[6.1]
  def change
    create_table :media do |t|
      t.string :name
      t.integer :category
      t.integer :automation
      t.string :apply_path

      t.timestamps
    end
  end
end
