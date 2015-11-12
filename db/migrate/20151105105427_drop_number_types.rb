class DropNumberTypes < ActiveRecord::Migration
  def change
    remove_column :phone_numbers, :number_type_id, :integer
    drop_table :number_types do |t|
      t.string   "name"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end
end
