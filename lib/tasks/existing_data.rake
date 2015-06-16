require 'net/http'

namespace :existing_data do
  desc "TODO"
  task slurp: :environment do
    bad = []

    Client.order(:name).each do |client|
      formatter = G5HerokuAppNameFormatter::Formatter.new(client.urn, ["cpns"])

      url = "#{formatter.cpns_url}/summary"

      response = Net::HTTP.get_response(URI.parse(url))
      if response.is_a?(Net::HTTPSuccess)
        puts "* #{url}"
        data = JSON.parse(response.body)
        if data["summary"].length > 0
          data["summary"].each do |entry|
            location = Location.find_by_urn(entry["urn"]) if entry["urn"] && !entry["urn"].blank?

            next unless location

            ["default", "mobile", "ppc"].each do |kind|
              existing_number = location.phone_numbers.find_by_number_kind(kind)

              if existing_number && existing_number.number == entry["#{kind}_number"]
                # do nothing
              elsif existing_number && existing_number.number != entry["#{kind}_number"]
                # update number if it doesn't match
                existing_number.update_attribute(:number, entry["#{kind}_number"])
              else
                # create number if it doesn't exist
                location.phone_numbers.create(number_kind: kind, number: entry["#{kind}_number"] )
              end
                  
            end

          end
        end

      else 
        puts "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX #{url} "
        bad << client.name
      end
    end

    puts "\n\n\n\n\n\n\n\n"
    puts "BAD:\n\n\n"
    puts bad.inspect
    puts "\n\n\n\n\n\n\n\n"
  end

end
