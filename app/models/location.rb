class Location < ActiveRecord::Base
  validates :urn, :name, presence: true
  validates :urn, uniqueness: true
  validates_format_of :urn, with: /g5-cl-[A-Za-z0-9]{7,8}-[A-Za-z\-]+/
end
