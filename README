# Caule

A simple DSL, based on [Anemone](https://rubygems.org/gems/anemone), to build web crawlers easily.

[![Build Status](https://secure.travis-ci.org/rafaelss/caule.png?branch=master)](http://travis-ci.org/rafaelss/caule)

## Installation

Add this line to your application's Gemfile:

    gem 'caule'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install caule

## Usage

    Caule.start("http://rubygems.org/") do |crawler|
      crawler.on_every_page do |page| # page is a Mechanize::Page instance
        puts page.uri
      end

      crawler.on_pages_like(/\//) do |page| # runs only on the home page
        puts page.uri
      end

      crawler.focus_crawl do |page| # filter the links that the bot must crawl
        page.links_with(:href => /\/gems/)
      end
    end

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

See LICENSE file
