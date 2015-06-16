class CreatePhoneNumbers < ActiveRecord::Migration
  def change
    create_table :phone_numbers do |t|
      t.integer :number_type_id
      t.string :number
      t.string :location_uid
      t.string :number_kind
      t.integer :location_id

      t.timestamps
    end
  end
end
