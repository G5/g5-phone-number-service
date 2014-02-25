require "spec_helper"

module RequestAuthHelper
  def http_login
    encoded_login = ["#{ENV['HTTP_BASIC_AUTH_NAME']}:#{ENV['HTTP_BASIC_AUTH_PASSWORD']}"].pack("m*")
    page.driver.header 'Authorization', "Basic #{encoded_login}"
  end
end
