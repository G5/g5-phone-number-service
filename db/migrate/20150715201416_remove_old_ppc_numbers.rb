class RemoveOldPpcNumbers < ActiveRecord::Migration
  def change
    PhoneNumber.where(number_kind: "ppc").destroy_all
  end
end
