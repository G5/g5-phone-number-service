class AddCpmCodeToNumbers < ActiveRecord::Migration
  def change
    add_column :phone_numbers, :cpm_code, :string
    add_column :phone_numbers, :notes, :string
  end
end
