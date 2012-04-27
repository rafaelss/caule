require "mechanize"
require "addressable/uri"

module Caule
  class Bot
    attr_reader :urls, :agent

    def initialize(*urls)
      @urls = urls.flatten
      @agent = Mechanize.new do |a|
        a.user_agent_alias = "Windows IE 7"
      end

      @on_pages_like_blocks = Hash.new { |hash,key| hash[key] = [] }
    end

    def on_every_page(&block)
      on_pages_like(/.+/, &block)
    end

    def on_pages_like(*patterns, &block)
      if patterns && !patterns.empty?
        patterns.each do |pattern|
          @on_pages_like_blocks[pattern] << block
        end
      end
    end

    def run
      urls.each do |url|
        page = agent.get(url)
        do_page_blocks(page)

        stack = links_to_follow(page)
        while l = stack.shift
          begin
            page = l.click
            next unless Mechanize::Page === page
            do_page_blocks(page)
            stack.push(*links_to_follow(page))
          rescue Mechanize::ResponseCodeError => ex
            puts "ERROR ---"
            puts ex.message
            puts ex.backtrace
          rescue Mechanize::RedirectLimitReachedError => ex
            puts "ERROR ---"
            puts ex.message
            puts ex.backtrace
          end
        end
      end
    end

    def focus_crawl(&block)
      @focus_crawl_block = block
    end

    protected

    def do_page_blocks(page)
      @on_pages_like_blocks.each do |pattern, blocks|
        blocks.each do |block|
          if page.uri.to_s =~ pattern
            block.call(page)
          end
        end
      end
    end

    def links_to_follow(page)
      if @focus_crawl_block
        links = []
        @focus_crawl_block.call(page, links)
        unless links.empty?
          links.flatten!
          links.compact!
        end
      else
        links = page.links
      end

      links.select { |link| visit_link?(link) }.uniq { |link| link.href }
    end

    def visit_link?(link)
      return false if link.href.to_s =~ /^javascript/
      return false if link.href.to_s =~ /^#/
      return false if agent.visited?(link)
      return true
    end
  end
end
