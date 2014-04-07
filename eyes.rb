require 'ruby-growl'
require_relative './discovery-rss-reader/rss'

def notify_with_growl message
    g = Growl.new "localhost", "ruby-growl"
    g.add_notification "ruby-growl Notification"
    g.notify "ruby-growl Notification", "Eye check", message
end 

last_time = Time.new

notify_with_growl "Started eyes at " + last_time.to_s

last_build_num = '0'

while true
    current_time = Time.new

    if(current_time - last_time >= (60 * 10))
        last_time = current_time
        puts "Growl notifying now, at " + current_time.to_s
        notify_with_growl "Glance 10 meters away for 5 seconds - sit up straight"
    end

    begin
        if(!RSSHealth.build_num.nil? && RSSHealth.build_num != last_build_num)
            build_num= RSSHealth.build_num
            notify_with_growl 'build #' + build_num + ' is ' + (RSSHealth.broken? ? 'broken' : 'good, no problems')
            last_build_num = build_num
        end
    rescue SocketError
    rescue Errno::ENETUNREACH
    end

    sleep(10)
end
