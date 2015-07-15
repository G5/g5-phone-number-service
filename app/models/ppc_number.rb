class PpcNumber < ActiveRecord::Base
  include G5Updatable::BelongsToLocation

  validates :cpm_code, :number, presence: true
  
  belongs_to :location
end
