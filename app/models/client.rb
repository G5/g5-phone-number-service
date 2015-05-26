class Client < G5Updatable::Client
  validates :urn, :name, presence: true
  validates :urn, uniqueness: true

  has_many :locations

  before_destroy :check_for_locations

  private

  def check_for_locations
    if locations.count > 0
      errors[:base] << "cannot delete a client with locations"
      return false
    end
  end
end
