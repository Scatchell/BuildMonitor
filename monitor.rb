require_relative './discovery-rss-reader/rss'

last_time = Time.new

last_build_num = '0'

GREEN_URL='http://www.traveltop.net/wp-content/uploads/2012/01/golden-mountain-lake-calm-forest-golden-lake-mountain.jpg'
RED_URL='http://hdwallsdesk.com/wp-content/uploads/2013/08/explosion_background.jpg'

while true
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
