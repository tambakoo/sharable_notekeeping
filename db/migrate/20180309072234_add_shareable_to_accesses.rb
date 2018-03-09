class AddShareableToAccesses < ActiveRecord::Migration[5.0]
  def change
    add_column :accesses, :shareable_type, :string
    add_column :accesses, :shareable_id, :integer
  end
end
