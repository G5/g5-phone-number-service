# This migration comes from g5_updatable (originally 20141211711945)
class UpdateNames < ActiveRecord::Migration
  def change
    G5Updatable::Client.all.each do |client|
      client.update_attributes(name: client.properties['name'])
    end
    G5Updatable::Location.all.each do |location|
      location.update_attributes(name: location.properties['name'])
    end
  end
end
