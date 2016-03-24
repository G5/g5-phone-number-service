class NumberFinder
  def initialize(params)
    @cpm_code = params["cpm_code"]
    @width = params["width"]
    @location = Location.find_by_urn(params["location_urn"])
  end

  def find_number
    return nil if @location.nil?
    if @cpm_code.present?
      phone_number = @location.phone_numbers.where(number_kind:"ppc", cpm_code:@cpm_code).first
    elsif @width.present? && @width < 768
      phone_number = @location.phone_numbers.where(number_kind:"mobile", cpm_code:@cpm_code).first
    else
      phone_number = @location.phone_numbers.where(number_kind:"default", cpm_code:@cpm_code).first
    end
    return phone_number
  end
end
