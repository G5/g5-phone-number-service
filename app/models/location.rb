class Location < ActiveRecord::Base
  validates :urn, :name, :default_number, presence: true
  validates :urn, uniqueness: true
end
