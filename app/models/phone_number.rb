class PhoneNumber < ActiveRecord::Base
  include G5Updatable::BelongsToLocation
  belongs_to :location

  validates :number, presence: true
  validates :cpm_code, :uniqueness => {:scope=>:location_id}, allow_nil: true
  validate :ppc_must_have_cpm_code

  NUMBER_KINDS = ["default", "mobile", "ppc"]

  def ppc_must_have_cpm_code
    if number_kind == "ppc" && cpm_code.blank?
      errors.add(:cpm_code, "A PPC number must have a cpm code")
    end
  end
end
