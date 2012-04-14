require "caule/version"

module Caule
  autoload :Bot, "caule/bot"

  def self.start(*urls)
    bot = Bot.new(*urls)
    yield bot
    bot.run
  end
end
