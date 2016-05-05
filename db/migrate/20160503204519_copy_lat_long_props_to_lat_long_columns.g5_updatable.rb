# This migration comes from g5_updatable (originally 20151103050229)
class CopyLatLongPropsToLatLongColumns < ActiveRecord::Migration
  def up
    G5Updatable::Location.all.each do |location|
      location.latitude = location.properties['latitude']
      location.longitude = location.properties['longitude']
      location.save
    end
  end

  def down
    G5Updatable::Location.all.each do |location|
      location.properties['latitude'] = location.latitude
      location.proper['longitude'] = location.longitude
      location.latitude = nil
      location.longitude = nil
      location.save
    end
  end
end
