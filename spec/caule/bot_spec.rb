require "spec_helper"

describe Caule::Bot do
  context "hooks" do
    describe "on_every_page" do
      subject { described_class.new("http://sfbay.craigslist.org/", "http://sfbay.craigslist.org/about") }

      it "runs on every page" do
        stub_request(:get, "http://sfbay.craigslist.org/").
          to_return(:status => 200, :body => "", :headers => { "Content-Type" => "text/html" })

        stub_request(:get, "http://sfbay.craigslist.org/about").
          to_return(:status => 200, :body => "", :headers => { "Content-Type" => "text/html" })

        subject.on_every_page do |page|
          page.uri.to_s.should match(/(\/|about)$/)
        end

        subject.run
      end
    end

    describe "on_pages_like" do
      subject { described_class.new("http://sfbay.craigslist.org/", "http://sfbay.craigslist.org/about") }

      it "runs on pages that match the regular expression passed" do
        stub_request(:get, "http://sfbay.craigslist.org/").
          to_return(:status => 200, :body => "", :headers => { "Content-Type" => "text/html" })

        stub_request(:get, "http://sfbay.craigslist.org/about").
          to_return(:status => 200, :body => "", :headers => { "Content-Type" => "text/html" })

        subject.on_pages_like(/about/) do |page|
          page.uri.to_s.should match(/about$/)
        end

        subject.run
      end
    end

    describe "focus_crawl" do
      subject { described_class.new("http://sfbay.craigslist.org/") }

      it "crawls only links pushed in links parameter" do
        stub_request(:get, "http://sfbay.craigslist.org/").
          to_return(:status => 200, :body => "<a href='/about'>about</a><a href='/forums'></a>", :headers => { "Content-Type" => "text/html" })

        stub_request(:get, "http://sfbay.craigslist.org/forums").
          to_return(:status => 200, :body => "", :headers => { "Content-Type" => "text/html" })

        subject.focus_crawl do |page, links|
          links.push(*page.links_with(:href => /forums$/))
        end

        subject.run
      end
    end
  end
end
