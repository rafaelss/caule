require "spec_helper"

describe Caule do
  it "instantiates bot, yield the instance and run the crawler" do
    bot = nil
    Caule.start { |b| bot = b }
    bot.should be_instance_of(Caule::Bot)
  end
end
