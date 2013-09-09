class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.integer :urn
      t.string :name
      t.string :non_mobile_number
      t.string :mobile_number
      t.string :ppc_number

      t.timestamps
    end
  end
end
