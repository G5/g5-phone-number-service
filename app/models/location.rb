class Location < G5Updatable::Location
  has_many :phone_numbers
  has_many :ppc_numbers

  # Add new Countries Here, that are not US or CA, or we could add country codes in the Hub?
  COUNTRY_DATA = {  "AU" => 
                      { 
                        country_code: "61"
                      }
                  }.with_indifferent_access

  def country_code_prefix
    country = properties['country']
    match_country = COUNTRY_DATA.fetch(country, "")
    country_code = match_country.blank? ? "1" : match_country[:country_code]
    "+#{country_code}-"
  end

  # def country_code_prefix
  #   country_code = properties['country_code']
  #   "+#{country_code}-"
  # end
end
