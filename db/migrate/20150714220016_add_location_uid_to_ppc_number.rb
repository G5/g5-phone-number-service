class AddLocationUidToPpcNumber < ActiveRecord::Migration
  def change
    add_column :ppc_numbers, :location_uid, :string
  end
end
