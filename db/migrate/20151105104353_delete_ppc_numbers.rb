class DeletePpcNumbers < ActiveRecord::Migration
  def change
    drop_table :ppc_numbers do |t|
      t.integer  "location_id"
      t.string   "cpm_code"
      t.string   "number"
      t.string   "notes"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "location_uid"
    end
  end
end
