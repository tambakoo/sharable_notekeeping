class RemoveStatusFormAccess < ActiveRecord::Migration[5.0]
  def change
    remove_column :accesses, :status
  end
end
