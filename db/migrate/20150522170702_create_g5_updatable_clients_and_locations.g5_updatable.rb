# This migration comes from g5_updatable (originally 20140709222005)
class CreateG5UpdatableClientsAndLocations < ActiveRecord::Migration
  def change
    create_table :g5_updatable_clients do |t|
      t.string :uid
      t.string :urn
      t.json :properties

      t.timestamps
    end
    add_index :g5_updatable_clients, :uid
    add_index :g5_updatable_clients, :urn

    create_table :g5_updatable_locations do |t|
      t.string :uid
      t.string :urn
      t.string :client_uid
      t.json :properties

      t.timestamps
    end
    add_index :g5_updatable_locations, :uid
    add_index :g5_updatable_locations, :urn
  end
end
