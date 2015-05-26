class PhoneNumber < ActiveRecord::Base
  include G5Updatable::BelongsToLocation

  belongs_to :location

  NUMBER_KINDS = ["Default", "Mobile", "PPC"]

end
