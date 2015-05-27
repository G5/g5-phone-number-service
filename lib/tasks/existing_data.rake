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
            location.phone_numbers.create(number_kind: "default", number: entry["default_number"] ) if location
            location.phone_numbers.create(number_kind: "mobile", number: entry["mobile_number"] ) if location
            location.phone_numbers.create(number_kind: "ppc", number: entry["ppc_number"] ) if location
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
