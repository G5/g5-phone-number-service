class AddClientIdToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :client_id, :integer
  end
end
