class Location < G5Updatable::Location
  has_many :phone_numbers
  has_many :ppc_numbers
end
