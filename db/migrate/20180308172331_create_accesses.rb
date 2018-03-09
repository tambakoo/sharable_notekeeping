class CreateAccesses < ActiveRecord::Migration[5.0]
  def change
    create_table :accesses do |t|
      t.references :note, foreign_key: true
      t.integer :sharer_id
      t.integer :shared_to_id
      t.integer :level
      t.boolean :status

      t.timestamps
    end
  end
end
