class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :urn
      t.string :name
      t.string :default_number
      t.string :mobile_number
      t.string :ppc_number

      t.timestamps
    end
  end
end
