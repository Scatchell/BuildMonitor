require_relative './discovery-rss-reader/rss'

last_time = Time.new

last_build_num = '0'

GREEN_URL='http://www.traveltop.net/wp-content/uploads/2012/01/golden-mountain-lake-calm-forest-golden-lake-mountain.jpg'
RED_URL='http://www.zingerbug.com/Backgrounds/background_images/airstrip_explosions.jpg'

while true
	begin
		if(!RSSHealth.build_num.nil? && RSSHealth.build_num != last_build_num)
			build_num = RSSHealth.build_num
			puts 'build #' + build_num + ' is ' + (RSSHealth.broken? ? 'broken' : 'good, no problems') + ' at ' + Time.now.to_s
			if RSSHealth.broken?
				`firefox #{RED_URL}`
				`play ~/Downloads/fail-trombone-03.wav`
			else
				`firefox #{GREEN_URL}`
			end

			last_build_num = build_num
		end
	rescue SocketError
		puts 'Socket error'
	rescue Errno::ENETUNREACH
		puts 'Can\'t reach server error'
	end

sleep(10)
	end
