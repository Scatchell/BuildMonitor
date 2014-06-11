require 'ruby-growl'
require_relative './discovery-rss-reader/rss'

last_time = Time.new

last_build_num = '0'

while true
    current_time = Time.new

    begin
        if(!RSSHealth.build_num.nil? && RSSHealth.build_num != last_build_num)
            build_num = RSSHealth.build_num
            puts 'build #' + build_num + ' is ' + (RSSHealth.broken? ? 'broken' : 'good, no problems')
            last_build_num = build_num
        end
    rescue SocketError
    rescue Errno::ENETUNREACH
    end

    sleep(10)
end
