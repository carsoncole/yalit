require "platform-api"

class Heroku

  attr_accessor :client

  def initialize
    super
    self.client = PlatformAPI.connect_oauth('c48e35eb-5370-4af4-8789-bebf988009a4')
  end
end