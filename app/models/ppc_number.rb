class PpcNumber < ActiveRecord::Base
  include G5Updatable::BelongsToLocation

  validates :cpm_code, :number, presence: true
  validates :cpm_code, :uniqueness => {:scope=>:location_id}
  
  belongs_to :location
end
