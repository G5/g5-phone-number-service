class PhoneNumber < ActiveRecord::Base
  include G5Updatable::BelongsToLocation
  belongs_to :location

  before_validation do
    self.number = sanitized_number if attribute_present?("number")
  end

  validates :number, presence: true
  validates_format_of :number, :with => /\d+/
  validates :cpm_code, :uniqueness => {:scope=>:location_id}, allow_nil: true
  validate :ppc_must_have_cpm_code

  NUMBER_KINDS = ["default", "mobile", "ppc"]

  def ppc_must_have_cpm_code
    if number_kind == "ppc" && cpm_code.blank?
      errors.add(:cpm_code, "A PPC number must have a cpm code")
    end
  end

  def display_number
    return "" if self.number.blank?
    pattern = /\A(\d{3})(\d{3})(\d*?)\Z/
    self.number.gsub(pattern,'\1-\2-\3')
  end

  def sanitized_number
    PhoneNumber.sanitize_number(self.number)
  end

  def self.find_by_number(num)
    PhoneNumber.where(number: sanitize_number(num)).first
  end

  def self.sanitize_number(num)
    num.gsub(/\D/, "")
  end

end
