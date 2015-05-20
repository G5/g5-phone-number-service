class Client < ActiveRecord::Base
  validates :urn, :name, presence: true
  validates :urn, uniqueness: true

  has_many :locations
end
