class CreateTables < ActiveRecord::Migration[8.0]
  def change
    create_table :tables do |t|
      t.string :name
      t.integer :max_capacity

      t.timestamps
    end

    add_index :tables, :name, unique: true
  end
end
