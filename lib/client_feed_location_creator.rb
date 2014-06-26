class ClientFeedLocationCreator
  def initialize(client_feed_url)
    @client_feed_url = client_feed_url
  end

  def work
    parsed_feed.orgs.each do |location|
      next if Location.exists?(urn: urn_for(location.format))
      create(location.format)
    end
  end

private

  def parsed_feed
    Microformats2.parse(@client_feed_url).first
  end

  def urn_for(location)
    location.uid.to_s.split("/").last
  end

  def create(location)
    Location.create(
      urn: urn_for(location),
      name: location.name.to_s,
      default_number: location.adr.try(:format).try(:tel).to_s
    )
  end
end
