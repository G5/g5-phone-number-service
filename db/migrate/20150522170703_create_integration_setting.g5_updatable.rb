# This migration comes from g5_updatable (originally 20141030211945)
class CreateIntegrationSetting < ActiveRecord::Migration
  def change
    create_table :g5_updatable_integration_settings do |t|
      t.string :uid
      t.string :urn
      t.string :location_uid
      t.string :vendor_action
      t.integer :job_frequency_in_minutes
      t.json :properties
      t.timestamps
    end

    add_index :g5_updatable_integration_settings, :urn
    add_index :g5_updatable_integration_settings, :uid
    add_index :g5_updatable_integration_settings, :vendor_action
    add_index :g5_updatable_integration_settings, [:location_uid, :vendor_action], name: :g5_u_is_loc_action
  end
end
