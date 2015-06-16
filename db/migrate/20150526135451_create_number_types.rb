class CreateNumberTypes < ActiveRecord::Migration
  def change
    create_table :number_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
