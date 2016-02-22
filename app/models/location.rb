class Location < G5Updatable::Location
  has_many :phone_numbers

  def ppc_numbers
    phone_numbers.where(number_kind: "ppc")
  end
end
