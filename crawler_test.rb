require ""

crawler = Caule::Bot.new("http://sfbay.craigslist.org/")
crawler.on_pages_like(/forums/) do |page|
  page.
end
crawler.on_every_page do

end
crawler.run
