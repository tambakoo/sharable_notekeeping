class AddIndexOnAccessesColumnsAgain < ActiveRecord::Migration[5.0]
  def change
    add_index :accesses, [:shared_to_id, :note_id], unique: true
  end
end
