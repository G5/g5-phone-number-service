module ApplicationHelper
  HEROKU_APP_NAME_MAX_LENGTH = 30
  SERVICES = %w(cms cpns cpas cls cxm)

  def current_urn
    request.host.split(".").first
  end

  def client_app_name
    current_urn[0...HEROKU_APP_NAME_MAX_LENGTH]
  end

  def client_url
    "http://#{client_app_name}.herokuapp.com/"
  end

  SERVICES.each do |service|
    define_method("#{service}_urn") do
      # Custom or replace the Client's app prefix
      ENV["#{service.upcase}_URN"] || current_urn.gsub(/-cpns-/, "-#{service}-")
    end

    define_method("#{service}_app_name") do
      # Custom or truncate to Heroku's max app name length
      ENV["#{service.upcase}_APP_NAME"] || send(:"#{service}_urn")[0...HEROKU_APP_NAME_MAX_LENGTH]
    end

    define_method("#{service}_url") do
      # Custom or Heroku URL
      ENV["#{service.upcase}_URL"] || ("http://" + send(:"#{service}_app_name") + ".herokuapp.com/")
    end
  end

  def fetch_phone_number(number_kind, numbers)
    selected_number = numbers.select { |number| number.number_kind == number_kind }
    selected_number.first.try(:number) || ""
  end
end
