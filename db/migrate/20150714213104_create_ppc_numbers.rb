class CreatePpcNumbers < ActiveRecord::Migration
  def change
    create_table :ppc_numbers do |t|
      t.integer :location_id
      t.string :cpm_code
      t.string :number
      t.string :notes

      t.timestamps
    end
  end
end
