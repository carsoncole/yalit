require "platform-api"

class Heroku

  attr_accessor :client

  def initialize
    super
    self.client = PlatformAPI.connect_oauth(ENV['HEROKU_API_KEY'])
  end
end
