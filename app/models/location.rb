class Location < G5Updatable::Location
  has_many :phone_numbers
  has_many :ppc_numbers

  def country_code_prefix
    country_code = properties['country_code']
    "+#{country_code}-"
  end
end
