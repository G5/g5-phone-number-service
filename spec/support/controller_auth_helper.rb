require "spec_helper"

module ControllerAuthHelper
  def http_login
    name = ENV["HTTP_BASIC_AUTH_NAME"]
    password = ENV["HTTP_BASIC_AUTH_PASSWORD"]
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(name,password)
  end
end
