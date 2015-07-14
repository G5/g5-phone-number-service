class PpcNumber < ActiveRecord::Base
  include G5Updatable::BelongsToLocation
  
  belongs_to :location
end
