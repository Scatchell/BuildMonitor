require 'rss'
require 'open-uri'

class RSSHealth
    URL = 'http://dhdb2bbld02.discsrv.co.za:8080/job/B2B-hospital-auths-hb-incoming-develop/rssAll'

    def self.broken?
        open(URL) do |rss|
            feed = RSS::Parser.parse(rss)

            return nil if feed.items.nil?
            return feed.items.first.title.to_s.include?('broken') || feed.items.first.title.to_s.include?('unstable')
        end
    end

    def self.build_num
        open(URL) do |rss|
            feed = RSS::Parser.parse(rss)
            return nil if feed.nil? || feed.items.nil?

            title = feed.items.first.title.to_s
            return title.slice(title.index('#') + 1, 4)
        end
    end
end
