class StandardizePhoneNumberFormat < ActiveRecord::Migration
  def change
    i = 0
    PhoneNumber.all.each do |n|
      if n.number.present?
        new_num = n.number.gsub(/\D/, '')
        if new_num.empty?
          # because some numbers are "DO NOT USE" for some reason
          new_num = (5555550000 + i).to_s
        end
        n.update_attributes!(number: new_num)
      end
    end
  end
end
